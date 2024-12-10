// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

interface I {}

contract A is I {}

contract EmptyContractType is I {
  A public a;
  I public i;

  function setValues() external {
    a = new A();
    i = a;
  }

  function getContractBytes() external view returns (bytes memory) {
    return address(a).code;
  }
}