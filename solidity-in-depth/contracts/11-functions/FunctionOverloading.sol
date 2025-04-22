// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract FunctionOverloading {
  function _sum(uint a, uint b) external pure returns (uint) {
    return a + b;
  }

  function sum(uint a, uint b) external pure returns (uint) {
    return a + b;
  }

  function sum(uint a, uint b, uint c) external pure returns (uint) {
    return a + b + c;
  }
}

//See https://github.com/ethereum/solidity/issues/3556
contract SelectOverloadedFunction {
  FunctionOverloading private functionOverloading;

  function(uint, uint) external pure returns (uint) extTwoArguments;
  function(uint, uint) internal pure returns (uint) intTwoArguments;

  constructor() {
    functionOverloading = new FunctionOverloading();
    //removing '_' causes compilation error:
    //Member "sum" not unique after argument-dependent lookup in contract Overloading
    extTwoArguments = functionOverloading._sum;
    //removing '_' causes compilation error:
    //No matching declaration found after variable lookup
    intTwoArguments = _product;
  }

  function _product(uint a, uint b) internal pure returns (uint) {
    return a * b;
  }

  function product(uint a, uint b) internal pure returns (uint) {
    return a * b;
  }

  function product(uint a, uint b, uint c) internal pure returns (uint) {
    return a * b * c;
  }

  function calculateExternal(uint a, uint b) external view returns (uint) {
    return extTwoArguments(a, b);
  }

  function calculateInternal(uint a, uint b) external view returns (uint) {
    return intTwoArguments(a, b);
  }
}
