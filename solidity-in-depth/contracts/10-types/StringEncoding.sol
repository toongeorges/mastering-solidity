// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract StringEncoding {
  string public a;

  function setValues() external {
    a = unicode"\n é è ç à ù µ";
  }
}