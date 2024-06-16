import { Injectable } from '@angular/core';
import { ethers } from 'ethers';
import { abi } from '../../../../solidity/artifacts/contracts/SeedTokenFactory.sol/SeedTokenFactory.json';
import { Subject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class SeedTokenFactoryService {
  private seedTokenFactory: ethers.BaseContract | null = null;

  public changes = new Subject<ethers.BaseContract | null>();

  public get(): any {
    return this.seedTokenFactory;
  }

  public async reset(provider: ethers.Provider, signer: ethers.Signer | null) {
    try {
      const address = await provider.resolveName('seed-token-factory.eth');
      if (address) {
        this.seedTokenFactory = new ethers.Contract(
          address,
          abi,
          provider
        );
        if (signer != null) {
          this.seedTokenFactory = this.seedTokenFactory.connect(signer);
        }
        this.changes.next(this.seedTokenFactory);
        console.log(`SeedTokenFactory@${address}`);
      } else {
        this.seedTokenFactory = null;
        this.changes.next(null);
        console.log(`no SeedTokenFactory set!`);
      }
    } catch (error: any) {
      console.error(error.message);
      this.seedTokenFactory = null;
      this.changes.next(null);
      console.log(`no SeedTokenFactory set!`);
    }
  }
}
