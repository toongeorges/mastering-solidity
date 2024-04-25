import { Component, OnInit } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { ethers } from 'ethers';
import { ProviderService } from '../../services/provider.service';

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
export class ConnectionBarComponent implements OnInit {
  constructor(
    private matIconRegistry: MatIconRegistry,
    private domSanitizer: DomSanitizer,
    private providerService: ProviderService
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

  ngOnInit(): void {
    console.log(`ethers version: ${ethers.version}`);
  }

  isMetaMaskConnected = false;
  isWalletConnectConnected = false;

  async connectMetaMask() {
    this.disconnectWalletConnect();
    const metamask = (window as any).ethereum;
    if (metamask) {
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
