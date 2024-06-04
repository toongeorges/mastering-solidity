import { Component } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { ProviderService } from '../../services/provider.service';
import { SeedTokenFactoryService } from '../../services/seed-token-factory.service';
import { CommonModule } from '@angular/common';

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
    public providerService: ProviderService,
    public seedTokenFactoryService: SeedTokenFactoryService
  ) {   
  }

  canCreateNewToken() {
    return this.providerService.isConnected()
        && (this.seedTokenFactoryService.get() != null);
  }

  openNewTokenDialog() {
    console.log("opening dialog");
  }
}
