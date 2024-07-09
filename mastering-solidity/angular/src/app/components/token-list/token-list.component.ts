import { AfterViewInit, Component, OnDestroy, ViewChild } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { CommonModule } from '@angular/common';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { Subscription } from 'rxjs';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { abi } from '../../../../../solidity/artifacts/contracts/SeedToken.sol/SeedToken.json';
import { ethers } from 'ethers';
import { MatDialog } from '@angular/material/dialog';
import { MintDialogComponent } from './mint-dialog/mint-dialog.component';
import { ProviderService } from '../../services/provider.service';
import { Clipboard } from '@angular/cdk/clipboard';
import { ChangeOwnerDialogComponent } from './change-owner-dialog/change-owner-dialog.component';

export interface Token {
  index: number;
  address: string;
  name: string;
  symbol: string;
  supply: bigint;
  balance: bigint;
  owner: string;
  isOwner: boolean;
  contract: ethers.Contract;
}

@Component({
  selector: 'app-token-list',
  standalone: true,
  imports: [
    CommonModule,
    MaterialDesignModule
  ],
  templateUrl: './token-list.component.html',
  styleUrl: './token-list.component.scss'
})
export class TokenListComponent implements AfterViewInit, OnDestroy {
  tokenColumns: string[] = [
    'symbol', 'supply', 'balance', 'mint', 'owner'
  ];

  @ViewChild('tokenSort') sort: MatSort;
  @ViewChild('tokenPaginator') paginator: MatPaginator;

  private changes: Subscription | null = null;
  private pendingFactories = [];

  constructor(
    public seedTokenFactoryService: SeedTokenFactoryService,
    private providerService: ProviderService,
    private dialog: MatDialog,
    private clipboard: Clipboard
  ) {}

  public SeedTokenCreationListener = async (event) => {
    const tokenAddress = event.args[0];
    const owner = event.args[1];

    const tokenList = this.seedTokenFactoryService.tokenList.data;

    const signer: any = this.seedTokenFactoryService.get().runner;
    const signerAddress = signer?.address;

    const contract = new ethers.Contract(
      tokenAddress,
      abi,
      signer
    );

    const token: Token = await this.getToken(
      signerAddress,
      tokenList.length,
      tokenAddress,
      owner,
      contract
    );

    tokenList.push(token);
    this.seedTokenFactoryService.tokenList.data = tokenList;
  };

  ngAfterViewInit(): void {
    this.changes = this.seedTokenFactoryService.changes.subscribe(
      (factory: any) => {
        this.pendingFactories.push(factory);
        if (this.pendingFactories.length == 1) {
          this.consumeAndUpdate();
        } //else another consumeAndUpdate() call is still running

        if (factory) {
          const filter = factory.filters.SeedTokenCreation(
            null, null, null, null
          );
          factory.on(
            filter,
            this.SeedTokenCreationListener
          );
        }
      }
    );
  }

  consumeAndUpdate() {
    if (this.pendingFactories.length > 0) {
      //we only care about the last pending factory
      const length = this.pendingFactories.length;
      const lastFactory = this.pendingFactories[length - 1];
      this.updateTokenList(lastFactory).then(() => {
        //remove all pending factories up to the processed factory
        this.pendingFactories = this.pendingFactories.slice(length);
        //process newly added factories if any
        this.consumeAndUpdate();
      }).catch((error) => {
        console.error(error.message);
        this.pendingFactories = [];
        this.providerService.disconnect();
        this.providerService.changes.next({ accounts: [] });
      });
    }
  }

  async updateTokenList(factory: any) {
    const tokens = [];
    this.paginator.length = tokens.length;

    this.seedTokenFactoryService.tokenList = new MatTableDataSource<Token>(tokens);
    this.seedTokenFactoryService.tokenList.sort = this.sort;
    this.seedTokenFactoryService.tokenList.paginator = this.paginator;

    this.seedTokenFactoryService.tokenCount = 0;
    this.seedTokenFactoryService.tokenIndex = 0;

    this.providerService.changes.next({});

    if (factory) {
      const signer = factory.runner;
      const signerAddress = signer?.address;

      const tokenCount = await factory.getNumberOfTokens();
      this.seedTokenFactoryService.tokenCount = tokenCount;
      for (let i = 0; i < tokenCount; i++) {
        this.seedTokenFactoryService.tokenIndex = i;
        const address = await factory.tokens(i);
        const contract = new ethers.Contract(
          address,
          abi,
          signer
        );

        const owner = await contract.owner();

        const token: Token = await this.getToken(
          signerAddress,
          i,
          address,
          owner,
          contract
        );

        tokens.push(token);

        this.seedTokenFactoryService.tokenList.data = tokens;
      }
      this.seedTokenFactoryService.tokenIndex = tokenCount;
      this.providerService.changes.next({});
    }
  }

  private async getToken(
    signerAddress: string,
    index: number,
    tokenAddress: string,
    owner: string,
    contract: ethers.Contract
  ): Promise<Token> {
    const decimals = await contract.decimals();
    const divisor = 10n ** decimals;
    const balance = signerAddress
                  ? (await contract.balanceOf(signerAddress)) / divisor
                  : 0n;

    return {
      index: index,
      address: tokenAddress,
      name: await contract.name(),
      symbol: await contract.symbol(),
      supply: (await contract.totalSupply()) / divisor,
      balance: balance,
      owner: owner,
      isOwner: (signerAddress?.toLowerCase() === owner?.toLowerCase()),
      contract: contract
    };
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }

  copyToClipboard(value: string) {
    this.clipboard.copy(value);
  }

  openMintDialog(element: Token) {
    this.dialog.open(MintDialogComponent, {
      data: {
        address: element.address,
        name: element.name,
        symbol: element.symbol,
        amount: '',
        contract: element.contract,
        onMint: async () => {
          await this.updateToken(element);
        }
      }
    });
  }

  openChangeOwnerDialog(element: Token) {
    this.dialog.open(ChangeOwnerDialogComponent, {
      data: {
        address: element.address,
        name: element.name,
        symbol: element.symbol,
        newOwnerAddress: '',
        contract: element.contract,
        onChangeOwner: async () => {
          await this.updateToken(element);
        }
      }
    });
  }

  async updateToken(element: Token) {
    const signerAddress = this.providerService.getAddress();
    const contract = element.contract;
    const decimals = await contract.decimals();
    const divisor = 10n ** decimals;

    const supply = (await contract.totalSupply()) / divisor;
    const balance = (await contract.balanceOf(signerAddress)) / divisor;
    const owner = await contract.owner();
    const isOwner = (signerAddress?.toLowerCase() === owner?.toLowerCase());

    const tokenList = this.seedTokenFactoryService.tokenList.data;
    const token = tokenList[element.index];
    token.supply = supply;
    token.balance = balance;
    token.owner = owner;
    token.isOwner = isOwner;

    this.providerService.changes.next({});
  }
}
