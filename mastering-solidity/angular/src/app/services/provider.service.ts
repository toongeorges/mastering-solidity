import { Injectable } from '@angular/core';
import { BrowserProvider, ethers } from 'ethers';
import { Subject } from 'rxjs';
import { infuraApiKey } from '../../../../solidity/infura.json';
import { SeedTokenFactoryService } from './seed-token-factory.service';

export type NetworkChange = {
  chainId?: string;
  accounts?: string[];
}

@Injectable({
  providedIn: 'root'
})
export class ProviderService {
  public changes = new Subject<NetworkChange>();
  public blockNumber: number;

  private eip1193: any = null;
  private provider: ethers.BrowserProvider | null = null;
  private defaultProvider: ethers.Provider;
  private signer: ethers.JsonRpcSigner | null = null;
  private network: ethers.Network | null = null;

  private isEip1193Disconnect = false;

  constructor(
    private seedTokenFactoryService: SeedTokenFactoryService
  ) {
    this.defaultProvider = ethers.getDefaultProvider("sepolia", {
      "infura": infuraApiKey,
      "exclusive": [
        "alchemy",
        "ankr",
        "cloudflare",
        "chainstack",
        "infura",
        "publicPolygon",
        "quicknode"
      ]
    });
  }

  private connectListener = (connectInfo: { readonly chainId: string; }) => {
    console.log(`connected to ${connectInfo.chainId}`);
  }

  private disconnectListener = async (error: { message: string; code: number; data?: unknown; }) => {
    console.log(`disconnected with message '${error.message}'(${error.code})`);
    await this.disconnect();
    this.changes.next({ accounts: [] });
  }

  private chainChangedListener = async (chainId: string) => {
    console.log(`chain changed to ${chainId}`);
    await this.connect(this.eip1193);
    this.changes.next({ chainId: chainId });
  }

  private accountsChangedListener = async (accounts: string[]) => {
    console.log(`accounts changed to ${accounts}`);
    if (accounts.length > 0) {
      await this.connect(this.eip1193);
    } else {
      await this.disconnect();
    }
    this.changes.next({ accounts: accounts });
  }

  private messageListener = (message: { readonly type: string; readonly data: unknown; }) => {
    console.log(`received message of type ${message.type}`);
  }

  private blockListener = (blockNumber: number) => {
    this.blockNumber = blockNumber;
  }

  public getProvider() {
    return this.provider || this.defaultProvider;
  }

  public async connect(
    eip1193: ethers.Eip1193Provider,
    isEip1193Disconnect = false
  ) {
    this.isEip1193Disconnect = isEip1193Disconnect;
    await this.disconnect();
    await this.defaultProvider.removeAllListeners();
    this.eip1193 = eip1193;
    await this.eip1193.on('connect', this.connectListener);
    await this.eip1193.on('disconnect', this.disconnectListener);
    await this.eip1193.on('chainChanged', this.chainChangedListener);
    await this.eip1193.on('accountsChanged', this.accountsChangedListener);
    await this.eip1193.on('message', this.messageListener);
    this.provider = new BrowserProvider(eip1193);
    const accounts = (eip1193 as any).accounts;
    if (accounts) {
      this.signer = await this.provider.getSigner(accounts[0]);
    } else {
      this.signer = await this.provider.getSigner();
    }
    this.network = await this.provider.getNetwork();
    await this.provider.on('block', this.blockListener);
    this.blockNumber = null;
    await this.seedTokenFactoryService.reset(this.getProvider(), this.signer);
  }

  public async disconnect() {
    await this.provider?.removeAllListeners();
    if (this.isEip1193Disconnect) {
      this.eip1193?.disconnect();
    }
    await this.eip1193?.removeAllListeners();
    this.eip1193 = null;
    this.provider = null;
    this.signer = null;
    this.network = null;
    await this.defaultProvider.on('block', this.blockListener);
    this.blockNumber = null;
    await this.seedTokenFactoryService.reset(this.getProvider(), null);
  }

  public isConnected(): boolean {
    return (this.provider != null);
  }

  public getAddress(): string | undefined {
    return this.signer?.address;
  }

  public getNetwork(): string {
    return `${this.network?.name}(${this.network?.chainId})`;
  }
}
