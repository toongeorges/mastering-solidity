import { Component } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';

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
export class ConnectionBarComponent {
  constructor(
    private matIconRegistry: MatIconRegistry,
    private domSanitizer: DomSanitizer
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

  isMetaMaskConnected = false;
  isWalletConnectConnected = false;

  connectMetaMask() {
    this.disconnectWalletConnect();
    this.isMetaMaskConnected = true;
  }

  disconnectMetaMask() {
    this.isMetaMaskConnected = false;
  }

  connectWalletConnect() {
    this.disconnectMetaMask();
    this.isWalletConnectConnected = true;
  }

  disconnectWalletConnect() {
    this.isWalletConnectConnected = false;
  }

  getConnectionString(): string {
    if (this.isMetaMaskConnected || this.isWalletConnectConnected) {
      return "connected";
    } else {
      return "not connected";
    }
  }
}
