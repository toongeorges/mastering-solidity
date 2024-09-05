//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;
pragma experimental SMTChecker;

contract SMTChecker {
  function mul(uint a, uint b) public pure returns (uint) {
    return a*b;
  }

  function multiplesOfTwo(uint a, uint b) public pure {
    require(a%2 == 0);
    require(b%2 == 0);
//    require((a > 0) && (a%3 == 0));
//    require((b > 0) && (b%3 == 0));
//    require((a > 0) && (a%3 == 0) && (a%2 == 1));
//    require((b > 0) && (b%3 == 0) && (b%2 == 1));
    assert(mul(a, b)%2 == 1);
  }
}