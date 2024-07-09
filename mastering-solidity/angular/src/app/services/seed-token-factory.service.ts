import { Injectable } from '@angular/core';
import { ethers } from 'ethers';
import { abi } from '../../../../solidity/artifacts/contracts/SeedTokenFactory.sol/SeedTokenFactory.json';
import { Subject } from 'rxjs';
import { MatTableDataSource } from '@angular/material/table';
import { Token } from '../components/token-list/token-list.component';

@Injectable({
  providedIn: 'root'
})
export class SeedTokenFactoryService {
  private seedTokenFactory: ethers.BaseContract | null = null;

  public changes = new Subject<ethers.BaseContract | null>();

  public tokenList = new MatTableDataSource<Token>([]);
  public tokenCount = 0;
  public tokenIndex = 0;

  public get(): any {
    return this.seedTokenFactory;
  }

  public async reset(provider: ethers.Provider, signer: ethers.Signer | null) {
    try {
      //remove SeedTokenCreationListener set in token-list.component.ts
      this.seedTokenFactory?.removeAllListeners();
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

  isShowFilter() {
    return (this.tokenCount > 0) && (this.tokenIndex == this.tokenCount);
  }

  isShowProgressBar() {
    return (this.tokenCount > 0) && (this.tokenIndex < this.tokenCount);
  }

  progression() {
    return Math.round(100*Number(this.tokenIndex)/Number(this.tokenCount));
  }
}
