// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract PackedUnsignedInteger {
  uint8 public a;
  uint8 public b;
  uint16 public c;
  uint32 public d;
  uint64 public e;
  uint128 public f;
  uint24 public g;
  uint40 public h;
  uint48 public i;
  uint56 public j;
  uint72 public k;
  uint80 public l;
  uint88 public m;
  uint96 public n;
  uint104 public o;

  function setValues() external {
    a = 1;
    b = 2;
    c = 3;
    d = 4;
    e = 5;
    f = 6;
    g = 7;
    h = 8;
    i = 9;
    j = 10;
    k = 11;
    l = 12;
    m = 13;
    n = 14;
    o = 15;
  }
}