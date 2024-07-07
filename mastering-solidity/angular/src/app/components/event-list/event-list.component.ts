import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { ethers } from 'ethers';
import { MatSort } from '@angular/material/sort';
import { MatPaginator } from '@angular/material/paginator';
import { MatTableDataSource } from '@angular/material/table';
import { Subscription } from 'rxjs';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-event-list',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    MaterialDesignModule
  ],
  templateUrl: './event-list.component.html',
  styleUrl: './event-list.component.scss'
})
export class EventListComponent implements OnInit, OnDestroy {
  from: string = '';
  to: string = '';
  owner: string = '';
  name: string = '';
  symbol: string = '';

  eventColumns: string[] = [
    'blockNumber', 'tokenAddress', 'owner'
  ];

  @ViewChild('eventSort') sort: MatSort;
  @ViewChild('eventPaginator') paginator: MatPaginator;

  eventList = new MatTableDataSource([]);
  isShowEvents = true;

  private changes: Subscription | null = null;

  constructor(
    private seedTokenFactoryService: SeedTokenFactoryService
  ) {}

  ngOnInit(): void {
    this.changes = this.seedTokenFactoryService.changes.subscribe(
      (factory: ethers.BaseContract | null) => {
        this.isShowEvents = (factory != null);
      }
    );
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }

  async searchEvents() {
    let from = Number(this.from);
    if (isNaN(from)) {
      from = 0;
    }
    let to: any = Number(this.to);
    if (isNaN(to) || !this.to) {
      to = 'latest';
    }
    const owner = this.splitAddress(this.owner);
    const name = this.split(this.name);
    const symbol = this.split(this.symbol);

    const contract = this.seedTokenFactoryService.get();
    const filter = contract.filters.SeedTokenCreation(
      null,
      owner,
      name,
      symbol
    );
    const events = await contract.queryFilter(
      filter,
      from,
      to
    );

    this.paginator.length = events.length;

    this.eventList = new MatTableDataSource(events);
    this.eventList.sort = this.sort;
    this.eventList.paginator = this.paginator;
  }

  private split(values: string): string[] {
    if (!values) {
      return null;
    } else {
      const split = [];
      values.split(',').forEach((value: string) => {
        split.push(value);
      });
      return split;
    }
  }

  private splitAddress(values: string): string[] {
    if (!values) {
      return null;
    } else {
      const split = [];
      values.split(',').forEach((value: string) => {
        const address = value.trim();
        if (ethers.isAddress(address)) {
          split.push(address);
        } else {
          console.error(`'${address}' is not a valid address`);
        }
      });
      return split;
    }
  }
}
