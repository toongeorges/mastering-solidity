import { Component } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { ProviderService } from '../../services/provider.service';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { CommonModule } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { NewTokenDialogComponent } from './new-token-dialog/new-token-dialog.component';

@Component({
  selector: 'app-new-token',
  standalone: true,
  imports: [
    CommonModule,
    MaterialDesignModule
  ],
  templateUrl: './new-token.component.html',
  styleUrl: './new-token.component.scss'
})
export class NewTokenComponent {
  constructor(
    private providerService: ProviderService,
    public seedTokenFactoryService: SeedTokenFactoryService,
    private dialog: MatDialog
  ) {}

  canCreateNewToken() {
    return this.providerService.isConnected()
        && (this.seedTokenFactoryService.get() != null);
  }

  openNewTokenDialog() {
    this.dialog.open(NewTokenDialogComponent, {
      data: {
        name: '',
        symbol: '',
        onCreateNewToken: () => {}
      }
    });
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value;
    this.seedTokenFactoryService.tokenList.filter = filterValue.trim().toLowerCase();
  }
}
