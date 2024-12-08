// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract FixedBytes {
  bytes1 public a;
  bytes1 public b;
  bytes2 public c;
  bytes4 public d;
  bytes8 public e;
  bytes16 public f;
  bytes3 public g;
  bytes5 public h;
  bytes6 public i;
  bytes7 public j;
  bytes9 public k;
  bytes10 public l;
  bytes11 public m;
  bytes12 public n;
  bytes13 public o;

  function setValues() external {
    a = 0x01;
    b = 0x02;
    c = 0x0303;
    d = 0x04040404;
    e = 0x0505050505050505;
    f = 0x06060606060606060606060606060606;
    g = 0x070707;
    h = 0x0808080808;
    i = 0x090909090909;
    j = 0x0a0a0a0a0a0a0a;
    k = 0x0b0b0b0b0b0b0b0b0b;
    l = 0x0c0c0c0c0c0c0c0c0c0c;
    m = 0x0d0d0d0d0d0d0d0d0d0d0d;
    n = 0x0e0e0e0e0e0e0e0e0e0e0e0e;
    o = 0x0f0f0f0f0f0f0f0f0f0f0f0f0f;
  }
}