// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract InternalFunctionType {
  uint public v;

  function() internal f1;
  function() internal f2;
  function() internal f3;
  function() internal returns (uint) f4;
  function() internal view returns (uint) f5;
  function() internal returns (uint) f6;
  function(uint) internal f7;
  function(uint, uint) internal f8;

  function setValues() public {
    v = 1;

    f1 = a;
    f2 = f1;
    f3 = b;
    f4 = c;
    f5 = d;
    f6 = d;
    f7 = e;
    f8 = f;
  }

  function a() private {
    v = v + 1;
  }

  function b() internal {
    v = v + 2;
  }

  function c() public returns (uint) {
    v = v + 3;
    return v;
  }

  function d() public view returns (uint) {
    return v + 4;
  }

  function e(uint x) public {
    v = v + x;
  }

  function f(uint x, uint y) public {
    v = x + y;
  }
}