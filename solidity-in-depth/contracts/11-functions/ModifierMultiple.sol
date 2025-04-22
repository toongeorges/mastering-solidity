// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierMultiple {
  int public a;

  modifier add() {
    a = a + 1;
    _;
  }

  modifier multiply() {
    a = a*3;
    _;
  }

  modifier subtract() {
    a = a - 2;
    _;
  }

  function process() external subtract multiply add {}
}

contract ModifierMultipleReverse {
  int public a;

  modifier add() {
    _;
    a = a + 1;
  }

  modifier multiply() {
    _;
    a = a*3;
  }

  modifier subtract() {
    _;
    a = a - 2;
  }

  function process() external subtract multiply add {}
}