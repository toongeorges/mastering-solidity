// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract UnsignedInteger {
  uint public a;
  uint public b;
  uint public c;

  function setValues() external {
    a = 3;
    b = a;
    c = 7;
  }
}