// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract ModifierWithoutArguments {
  uint public a;

  //modifiers contain at least 1 '_' statement
  modifier modify() {
    a = a + 3;
    _;
    a = a - 1;
  }

  function calculate() external modify {
    a = a*2;
    //modify(); //modifiers cannot be called within functions, only annotated to functions
  }

  //function _() internal {} //DeclarationError: The name "_" is reserved.
}