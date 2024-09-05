//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;
pragma abicoder v2;

struct Point {
  uint x;
  uint y;
}

contract AbiCoder {
  function getX(Point calldata p) external pure returns (uint) {
    return p.x;
  }

  function getY(Point calldata p) external pure returns (uint) {
    return p.y;
  }
}