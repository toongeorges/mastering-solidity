import { Component, OnDestroy, OnInit } from '@angular/core';
import { MaterialDesignModule } from '../../modules/material-design/material-design.module';
import { MatIconRegistry } from '@angular/material/icon';
import { DomSanitizer } from '@angular/platform-browser';
import { CommonModule } from '@angular/common';
import { ethers } from 'ethers';
import { NetworkChange, ProviderService } from '../../services/provider.service';
import { Subscription } from 'rxjs';
import { project_id } from '../../../config/wallet-connect.json';
import { EthereumProvider } from '@walletconnect/ethereum-provider';

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
    public providerService: ProviderService
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
    await this.providerService.disconnect();
    this.changes = this.providerService.changes.subscribe((change: NetworkChange) => {
      if (change.accounts && (change.accounts.length == 0)) {
        this.isMetaMaskConnected = false;
        this.isWalletConnectConnected = false;
      }
    });
    await this.initMetaMask();
    if (!this.isMetaMaskConnected) {
      await this.initWalletConnect();
    }
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

  async initWalletConnect() {
    const walletconnect = await EthereumProvider.init({
      projectId: project_id,
      chains: [],
      optionalChains: [1, 5, 11155111],
      showQrModal: true,
      metadata: {
        name: 'Mastering Solidity',
        description: 'The metadata is also required now, configuration in https://cloud.walletconnect.com/',
        url: 'https://localhost:4200',
        icons: []
      },
      events: ["disconnect", "chainChanged", "accountsChanged"]
    });
    try {
      const accounts: string[] = await walletconnect.request({ method: 'eth_accounts' });
      if (accounts.length > 0) {
        await this.providerService.connect(walletconnect, true);
        this.isWalletConnectConnected = true;
      }
    } catch (error: any) {
      console.log(`Could not connect to WalletConnect: ${error.message}`);
    }
  }

  async connectMetaMask() {
    const metamask = (window as any).ethereum;
    if (metamask && metamask.isMetaMask) {
      this.isWalletConnectConnected = false;
      await this.providerService.connect(metamask);
      this.isMetaMaskConnected = true;
    }
  }

  async disconnectMetaMask() {
    this.isMetaMaskConnected = false;
    await this.providerService.disconnect();
  }

  async connectWalletConnect() {
    this.isMetaMaskConnected = false;
    const walletconnect = await EthereumProvider.init({
      projectId: project_id,
      chains: [],
      optionalChains: [1, 5, 11155111],
      showQrModal: true,
      metadata: {
        name: 'Mastering Solidity',
        description: 'The metadata is also required now, configuration in https://cloud.walletconnect.com/',
        url: 'https://localhost:4200',
        icons: []
      },
      events: ["disconnect", "chainChanged", "accountsChanged"]
    });
    try {
      await walletconnect.connect();
      await this.providerService.connect(walletconnect, true);
      this.isWalletConnectConnected = true;
    } catch (error: any) {
      await this.disconnectWalletConnect();
      console.log(`Could not connect to WalletConnect: ${error.message}`);
    }
  }

  async disconnectWalletConnect() {
    this.isWalletConnectConnected = false;
    await this.providerService.disconnect();
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
