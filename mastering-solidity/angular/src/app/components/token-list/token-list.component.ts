import { AfterViewInit, ChangeDetectorRef, Component, OnDestroy, ViewChild } from '@angular/core';
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

  constructor(
    public seedTokenFactoryService: SeedTokenFactoryService,
    private providerService: ProviderService,
    private changeDetectorRef: ChangeDetectorRef,
    private dialog: MatDialog,
    private clipboard: Clipboard
  ) {}

  ngAfterViewInit(): void {
    this.changes = this.seedTokenFactoryService.changes.subscribe(
      async (factory: any) => {
        const tokens = [];
        this.paginator.length = tokens.length;

        this.seedTokenFactoryService.tokenList = new MatTableDataSource<Token>(tokens);
        this.seedTokenFactoryService.tokenList.sort = this.sort;
        this.seedTokenFactoryService.tokenList.paginator = this.paginator;

        this.seedTokenFactoryService.tokenCount = 0;
        this.seedTokenFactoryService.tokenIndex = 0;

        this.changeDetectorRef.detectChanges();

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

            const decimals = await contract.decimals();
            const divisor = 10n ** decimals;
            const balance = signerAddress
                          ? (await contract.balanceOf(signerAddress)) / divisor
                          : 0n;
            const owner = await contract.owner();

            const token: Token = {
              index: i,
              address: address,
              name: await contract.name(),
              symbol: await contract.symbol(),
              supply: (await contract.totalSupply()) / divisor,
              balance: balance,
              owner: owner,
              isOwner: (signerAddress?.toLowerCase() === owner?.toLowerCase()),
              contract: contract
            };

            tokens.push(token);
            this.paginator.length = tokens.length;

            this.seedTokenFactoryService.tokenList = new MatTableDataSource<Token>(tokens);
            this.seedTokenFactoryService.tokenList.sort = this.sort;
            this.seedTokenFactoryService.tokenList.paginator = this.paginator;

            this.changeDetectorRef.detectChanges();
          }
          this.seedTokenFactoryService.tokenIndex = tokenCount;
          this.changeDetectorRef.detectChanges();
        }
      }
    );
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

    this.changeDetectorRef.detectChanges();
  }
}
