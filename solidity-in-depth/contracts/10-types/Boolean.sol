// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Boolean {
  bool public a;
  bool public b;
  bool public c;
  bool public d;

  function setValues() external {
    a = true;
    b = a;
    c = false;
    d = true;
  }
}