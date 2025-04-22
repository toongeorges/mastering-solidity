// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract Multiplier {
  uint public factor;

  constructor(uint f) {
    factor = f;
  }

  function multiply(uint base) external view returns (uint) {
    return factor*base;
  }
}

contract MultiplierFactory {
  mapping(uint => address) public location;

  function createMultiplier(uint fac) external {
    //constructors cannot be called directly,
    //but are called implicitly through the keyword 'new'
    // + the name of the smart contract
    // + argument list,
    //which creates a new instance of the smart contract on the blockchain
    location[fac] = address(new Multiplier(fac));
  }
}