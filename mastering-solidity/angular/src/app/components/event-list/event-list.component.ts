import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';

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

  searchEvents() {
    let from = Number(this.from);
    if (isNaN(from)) {
      from = 0;
    }
    let to: any = Number(this.to);
    if (isNaN(to) || !this.to) {
      to = 'latest';
    }
    const owner = this.split(this.owner);
    const name = this.split(this.name);
    const symbol = this.split(this.symbol);
    console.log(`searching events from ${from} to ${to}`);
    console.dir(owner);
    console.dir(name);
    console.dir(symbol);
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
}
