// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

struct Point {
  uint x;
  uint y;
}

contract FunctionReturnValues {
  uint public a;
  uint public b;

  uint public removedA;
  uint public removedB;

  function updateA(uint x) external returns (uint) {
    uint previous = a;
    a = x;
    return previous;
  }

  function updateAB(uint x, uint y) external returns (uint, uint) {
    uint previousA = a;
    uint previousB = b;
    a = x;
    b = y;
    return (previousA, previousB);
  }

  function updateABAlternative(uint x, uint y) external returns (uint u, uint v) {
    uint previousA = a;
    uint previousB = b;
    a = x;
    b = y;
    u = previousA;
    v = previousB;
  }

  function storeRemovedA(uint x) external {
    removedA = 0;
    removedA = this.updateA(x);
  }

  function storeRemovedAB(uint x, uint y) external {
    removedA = 0;
    removedB = 0;
    (removedA, removedB) = this.updateAB(x, y);
  }

  function storeRemovedABAlternative(uint x, uint y) external {
    removedA = 0;
    removedB = 0;
    (removedA, removedB) = this.updateABAlternative(x, y);
  }

  function returnAssigned(uint x, uint y) external pure returns (uint c, uint d) {
    c = x;
    d = y;
  }

  //external functions cannot return:
  // - reference types with data location 'storage'
  // - mappings (always have data location storage)
  // - internal function types
  //
  // see https://docs.soliditylang.org/en/stable/contracts.html#return-variables
  function returnAnything(string calldata message) external view
    returns (uint[3] memory, bool, string calldata, Point memory) {
    return ([uint(1), 2, 3], true, message, Point(a, b));
  }
}
