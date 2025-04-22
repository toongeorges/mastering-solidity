// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierRevert {
  uint public a;

  modifier handle() {
    a = 1;
    _;
    a = 2; //unreachable code
  }

  function fail() external handle {
    revert();
  }
}