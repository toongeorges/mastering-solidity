// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Bytes {
  bytes public a;
  bytes public b;
  bytes public c;
  bytes public d;
  bytes public e;

  function setValues() external {
    a = "one two three four five six seven eight nine ten";
    b = a;
    c = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty";
    d = "short string";
    e = hex"f1_f2_f3_f4_f5_f6_f7_f8_f9_fa_fb_fc_fd_fe_ff";
  }
}