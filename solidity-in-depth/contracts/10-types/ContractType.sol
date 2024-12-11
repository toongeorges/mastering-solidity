// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract ContractType {
  B public a;
  B public b;
  B public c;
  C public d;

  function setValues() external {
    a = new B(3);
    b = a;
    d = new C(address(a));
    c = new B(7);
  }
}

contract B {
  uint public x;

  constructor(uint y) {
    x = y;
  }
}

contract C {
  address public x;

  constructor(address y) {
    x = y;
  }
}