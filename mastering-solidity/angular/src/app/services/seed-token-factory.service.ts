import { Injectable } from '@angular/core';
import { ethers } from 'ethers';
import { abi } from '../../../../solidity/artifacts/contracts/SeedTokenFactory.sol/SeedTokenFactory.json';

@Injectable({
  providedIn: 'root'
})
export class SeedTokenFactoryService {
  private seedTokenFactory: ethers.Contract | null = null;

  public get() {
    return this.seedTokenFactory;
  }

  public async reset(provider: ethers.Provider) {
    try {
      const address = await provider.resolveName('seed-token-factory.eth');
      if (address) {
        this.seedTokenFactory = new ethers.Contract(
          address,
          abi,
          provider
        );
        console.log(`SeedTokenFactory@${address}`);
      } else {
        this.seedTokenFactory = null;
        console.log(`no SeedTokenFactory set!`);
      }
    } catch (error: any) {
      console.error(error.message);
      this.seedTokenFactory = null;
      console.log(`no SeedTokenFactory set!`);
    }
  }
}
