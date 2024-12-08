// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract PackedSignedInteger {
  int8 public a;
  int8 public b;
  int16 public c;
  int32 public d;
  int64 public e;
  int128 public f;
  int24 public g;
  int40 public h;
  int48 public i;
  int56 public j;
  int72 public k;
  int80 public l;
  int88 public m;
  int96 public n;
  int104 public o;

  function setValues() external {
    a = -1;
    b = 2;
    c = -3;
    d = 4;
    e = -5;
    f = 6;
    g = -7;
    h = 8;
    i = -9;
    j = 10;
    k = -11;
    l = 12;
    m = -13;
    n = 14;
    o = -15;
  }
}