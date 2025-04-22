// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierConditional {
  uint public a;

  modifier double(bool select) {
    if (select) {
        a = 1;
    } else {
        _;
    }
  }

  function setOrDouble(bool select, uint init) external double(select) {
    a = init;
  }
}