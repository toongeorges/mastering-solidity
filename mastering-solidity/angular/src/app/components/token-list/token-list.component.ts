import { AfterViewInit, ChangeDetectorRef, Component, OnDestroy, ViewChild } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { CommonModule } from '@angular/common';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { Subscription } from 'rxjs';
import { MatTableDataSource } from '@angular/material/table';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';

export interface Token {
  index: number;
  address: string;
  name: string;
  symbol: string;
  supply: string;
  balance: string;
  owner: string;
  isOwner: boolean;
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

  async ngAfterViewInit(): Promise<void> {
    this.changes = this.seedTokenFactoryService.changes.subscribe(
      (factory: any) => {
        const tokens = [];
        this.paginator.length = tokens.length;

        this.tokenList = new MatTableDataSource<Token>(tokens);
        this.tokenList.sort = this.sort;
        this.tokenList.paginator = this.paginator;

        this.tokenCount = 0;
        this.tokenIndex = 0;

        this.changeDetectorRef.detectChanges();
      }
    );
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }
}
