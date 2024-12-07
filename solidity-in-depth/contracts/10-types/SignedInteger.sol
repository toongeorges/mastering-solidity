// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract SignedInteger {
  int public a;
  int public b;
  int public c;

  function setValues() external {
    a = -3;
    b = a;
    c = 7;
  }
}