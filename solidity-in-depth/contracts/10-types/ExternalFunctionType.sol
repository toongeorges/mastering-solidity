// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract ExternalFunctionType {
  ExternalFunctions public ef = new ExternalFunctions();

  function() external public f1;
  function() external public f2;
  function() external public f3;
  function() external returns (uint) public f4;
  function() external view returns (uint) public f5;
  function() external returns (uint) public f6;
  function(uint) external public f7;
  function(uint, uint) external public f8;

  function setValues() public {
    f1 = ef.a;
    f2 = f1;
    f3 = ef.b;
    f4 = ef.c;
    f5 = ef.d;
    f6 = ef.d;
    f7 = ef.e;
    f8 = ef.f;
  }
}

contract ExternalFunctions {
  uint public v = 1;

  function a() external {
    v = v + 1;
  }

  function b() public {
    v = v + 2;
  }

  function c() external returns (uint) {
    v = v + 3;
    return v;
  }

  function d() external view returns (uint) {
    return v + 4;
  }

  function e(uint x) external {
    v = v + x;
  }

  function f(uint x, uint y) external {
    v = x + y;
  }
}