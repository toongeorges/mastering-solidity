// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract String {
  string public a;
  string public b;
  string public c;
  string public d;

  function setValues() external {
    a = "one two three four five six seven eight nine ten";
    b = a;
    c = "eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty";
    d = "short string";
  }
}