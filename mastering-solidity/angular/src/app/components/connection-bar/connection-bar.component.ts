import { ChangeDetectorRef, Component, OnDestroy, OnInit } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { ethers } from 'ethers';
import { NetworkChange, ProviderService } from '../../services/provider.service';
import { Subscription } from 'rxjs';

@Component({
  selector: 'app-connection-bar',
  standalone: true,
  imports: [
    CommonModule,
    MaterialDesignModule
  ],
  templateUrl: './connection-bar.component.html',
  styleUrl: './connection-bar.component.scss'
})
export class ConnectionBarComponent implements OnInit, OnDestroy {
  constructor(
    private matIconRegistry: MatIconRegistry,
    private domSanitizer: DomSanitizer,
    private providerService: ProviderService,
    private changeDetectorRef: ChangeDetectorRef
  ) {
    this.matIconRegistry.addSvgIcon(
      "metamask",
      this.domSanitizer.bypassSecurityTrustResourceUrl("assets/metamask.svg")
    );
    this.matIconRegistry.addSvgIcon(
      "walletconnect",
      this.domSanitizer.bypassSecurityTrustResourceUrl("assets/walletconnect.svg")
    );
  }

  private changes: Subscription | null = null;

  async ngOnInit(): Promise<void> {
    console.log(`ethers version: ${ethers.version}`);
    this.changes = this.providerService.changes.subscribe((change: NetworkChange) => {
      if (change.accounts && (change.accounts.length == 0)) {
        this.isMetaMaskConnected = false;
        this.isWalletConnectConnected = false;
      }
      this.changeDetectorRef.detectChanges();
    });
    await this.initMetaMask();
  }

  ngOnDestroy(): void {
    this.changes?.unsubscribe();
  }

  isMetaMaskConnected = false;
  isWalletConnectConnected = false;

  async initMetaMask() {
    const metamask = (window as any).ethereum;
    if (metamask && metamask.isMetaMask) {
      const accounts: string[] = await metamask.request({ method: 'eth_accounts' });
      if (accounts.length > 0) {
        await this.connectMetaMask();
      }
    }
  }

  async connectMetaMask() {
    this.disconnectWalletConnect();
    const metamask = (window as any).ethereum;
    if (metamask && metamask.isMetaMask) {
      await this.providerService.connect(metamask);
      this.isMetaMaskConnected = true;
    }
  }

  disconnectMetaMask() {
    this.isMetaMaskConnected = false;
    this.providerService.disconnect();
  }

  connectWalletConnect() {
    this.disconnectMetaMask();
    this.isWalletConnectConnected = true;
  }

  disconnectWalletConnect() {
    this.isWalletConnectConnected = false;
  }

  getConnectionString(): string {
    if (this.providerService.isConnected()) {
      return `connected to ${this.providerService.getNetwork()} `
           + `with ${this.providerService.getAddress()}`;
    } else {
      return "not connected";
    }
  }
}
