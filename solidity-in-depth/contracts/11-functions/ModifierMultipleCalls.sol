// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierMultipleCalls {
  uint public a;

  modifier modify() {
    _;
    a = a + 3;
    _;
    a = a - 1;
    _;
  }

  function calculate() external modify {
    a = a*2;
  }
}