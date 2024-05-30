import { Injectable } from '@angular/core';
import { BrowserProvider, ethers } from 'ethers';
import { Subject } from 'rxjs';

export type NetworkChange = {
  chainId?: string;
  accounts?: string[];
}

@Injectable({
  providedIn: 'root'
})
export class ProviderService {
  public changes = new Subject<NetworkChange>();

  private eip1193: any = null;
  private provider: ethers.BrowserProvider | null = null;
  private signer: ethers.JsonRpcSigner | null = null;
  private network: ethers.Network | null = null;

  private isEip1193Disconnect = false;

  private connectListener = (connectInfo: { readonly chainId: string; }) => {
    console.log(`connected to ${connectInfo.chainId}`);
  }

  private disconnectListener = (error: { message: string; code: number; data?: unknown; }) => {
    console.log(`disconnected with message '${error.message}'(${error.code})`);
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
      this.disconnect();
    }
    this.changes.next({ accounts: accounts });
  }

  private messageListener = (message: { readonly type: string; readonly data: unknown; }) => {
    console.log(`received message of type ${message.type}`);
  }

  public async connect(
    eip1193: ethers.Eip1193Provider,
    isEip1193Disconnect = false
  ) {
    this.isEip1193Disconnect = isEip1193Disconnect;
    this.disconnect();
    this.eip1193 = eip1193;
    this.eip1193.on('connect', this.connectListener);
    this.eip1193.on('disconnect', this.disconnectListener);
    this.eip1193.on('chainChanged', this.chainChangedListener);
    this.eip1193.on('accountsChanged', this.accountsChangedListener);
    this.eip1193.on('message', this.messageListener);
    this.provider = new BrowserProvider(eip1193);
    this.signer = await this.provider.getSigner();
    this.network = await this.provider.getNetwork();
  }

  public disconnect() {
    if (this.isEip1193Disconnect) {
      this.eip1193?.disconnect();
    }
    this.eip1193?.removeListener('connect', this.connectListener);
    this.eip1193?.removeListener('disconnect', this.disconnectListener);
    this.eip1193?.removeListener('chainChanged', this.chainChangedListener);
    this.eip1193?.removeListener('accountsChanged', this.accountsChangedListener);
    this.eip1193?.removeListener('message', this.messageListener);
    this.eip1193 = null;
    this.provider = null;
    this.signer = null;
    this.network = null;
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
