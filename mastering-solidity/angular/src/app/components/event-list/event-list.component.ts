import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { ethers } from 'ethers';

@Component({
  selector: 'app-event-list',
  standalone: true,
  imports: [
    FormsModule,
    MaterialDesignModule
  ],
  templateUrl: './event-list.component.html',
  styleUrl: './event-list.component.scss'
})
export class EventListComponent {
  from: string = '';
  to: string = '';
  owner: string = '';
  name: string = '';
  symbol: string = '';

  constructor(
    private seedTokenFactoryService: SeedTokenFactoryService
  ) {}

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

    events.forEach((event: any) => {
      console.log(`event with block number: ${event.blockNumber}`);
      console.log(`topics: ${event.topics}`);
      console.log(`data: ${event.data}`);
    });
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
