import { Injectable } from '@angular/core';
import { BrowserProvider, ethers } from 'ethers';

@Injectable({
  providedIn: 'root'
})
export class ProviderService {
  private provider: ethers.BrowserProvider | null = null;
  private signer: ethers.JsonRpcSigner | null = null;
  private network: ethers.Network | null = null;

  public async connect(eip1193: ethers.Eip1193Provider) {
    this.disconnect();
    this.provider = new BrowserProvider(eip1193);
    this.signer = await this.provider.getSigner();
    this.network = await this.provider.getNetwork();
  }

  public disconnect() {
    //do not call this.provider?.destroy()
    //this will cause problems later on when reconnecting
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
