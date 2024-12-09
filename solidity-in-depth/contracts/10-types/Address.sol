// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Address {
  address public a;
  address public b;
  address public c;
  address payable public owner;

  function setValues() external {
    a = 0x43A4202CE5033A8a5793b768B981e81cd2f73B52;
    b = a;
    c = 0xe8Fe258bE6d05ABd318355e7c27F2518462864DD;
    owner = payable(msg.sender);
  }
}