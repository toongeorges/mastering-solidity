// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierWithArguments {
  int public a;

  modifier modify(int initialValue, int endDecrement) {
    a = initialValue;
    _;
    a = a - endDecrement;
  }

  function calculate(int initialValue, int endDecrement)
  external modify(initialValue, endDecrement) {
    a = a*2;
  }
}