// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierReturn {
  uint public a;
  uint public b;

  modifier modify() {
    a = 1;
    _;
    a = a + 1;
    _;
    a = a + 1;
    _;
    a = a + 1;
  }

  function returnValue() internal modify returns (uint){
    a = a*2;
    return a;
  }

  function storeReturnValue() external {
    b = returnValue();
  }
}