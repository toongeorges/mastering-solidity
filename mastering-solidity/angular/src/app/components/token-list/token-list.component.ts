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

  public tokenList = new MatTableDataSource<Token>([]);
  public tokenCount = 0;
  public tokenIndex = 0;

  @ViewChild('tokenSort') sort: MatSort;
  @ViewChild('tokenPaginator') paginator: MatPaginator;

  private changes: Subscription | null = null;

  constructor(
    private seedTokenFactoryService: SeedTokenFactoryService,
    private changeDetectorRef: ChangeDetectorRef
  ) {}

  ngAfterViewInit(): void {
    this.changes = this.seedTokenFactoryService.changes.subscribe(
      async (factory: any) => {
        const tokens = [];
        this.paginator.length = tokens.length;

        this.tokenList = new MatTableDataSource<Token>(tokens);
        this.tokenList.sort = this.sort;
        this.tokenList.paginator = this.paginator;

        this.tokenCount = 0;
        this.tokenIndex = 0;

        this.changeDetectorRef.detectChanges();

        if (factory) {
          const signer = factory.runner;
          const signerAddress = signer?.address;

          const tokenCount = await factory.getNumberOfTokens();
          this.tokenCount = tokenCount;
          for (let i = 0; i < tokenCount; i++) {
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

            this.tokenList = new MatTableDataSource<Token>(tokens);
            this.tokenList.sort = this.sort;
            this.tokenList.paginator = this.paginator;

            this.tokenIndex = i;

            this.changeDetectorRef.detectChanges();
          }
        }
      }
    );
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }
}
