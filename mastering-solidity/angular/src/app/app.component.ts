import { ChangeDetectorRef, Component, OnDestroy, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { MaterialDesignModule } from './modules/material-design/material-design.module';
import { ConnectionBarComponent } from './components/connection-bar/connection-bar.component';
import { NewTokenComponent } from './components/new-token/new-token.component';
import { Subscription } from 'rxjs';
import { NetworkChange, ProviderService } from './services/provider.service';
import { TokenListComponent } from './components/token-list/token-list.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    RouterOutlet,
    MaterialDesignModule,
    ConnectionBarComponent,
    NewTokenComponent,
    TokenListComponent
  ],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit, OnDestroy {
  private changes: Subscription | null = null;

  constructor(
    private providerService: ProviderService,
    private changeDetectorRef: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.changes = this.providerService.changes.subscribe((change: NetworkChange) => {
      this.changeDetectorRef.detectChanges();
    });
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }
}
