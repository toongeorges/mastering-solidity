// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract FunctionParameters {
  uint public a;
  uint public b;
  string public c;
  string public d;

  function setA(uint x) external {
    a = x;
  }

  function setAB(uint x, uint y, uint, string calldata, address, bool[] calldata) external {
    a = x;
    b = y;
  }

  //use calldata when you do not change the parameter
  //
  //the data location for parameters of reference type in external functions:
  // - 'calldata' is normally used
  // - 'storage' is only allowed for internal functions
  // - 'memory' only makes sense if the value will be changed within the function
  //   or internal functions called by the function,
  //   since the external function call will reinitialize memory
  //   and not reuse a value that already exists somewhere else in memory
  function setC(string calldata z) external {
    c = z;
  }

  //use memory when you change the parameter
  //
  //the logic could be done more efficiently, but it is just an example
  function hash(uint[] memory input) external {
    for (uint i = 1; i < input.length; i++) {
      input[i] = calculateHashPart(i, input);
    }
    a = input[input.length - 1];
  }

  //for internal functions, all data locations may make sense
  function calculateHashPart(uint i, uint[] memory input) internal pure returns (uint) {
    return input[i]^input[i - 1];
  }

  function copyDFromC() external {
    copyD(c);
  }

  //storage can not be used in external functions
  function copyD(string storage source) internal {
    d = source;
  }
}