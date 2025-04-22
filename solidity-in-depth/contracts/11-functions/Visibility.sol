// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract A {
  uint public publicCount;
  uint public externalCount;
  uint public internalCount;
  uint public privateCount;

  function pub() public {
    publicCount++;
  }

  function extl() external {
    externalCount++;
  }

  function intl() internal {
    internalCount++;
  }

  function priv() private {
    privateCount++;
  }

  function callInternalFunctions() external {
    pub();
    //extl(); //not possible
    intl();
    priv();
  }

  function callExternalFunctions() external {
    A a = A(this);
    a.pub();
    a.extl();
    //a.intl(); //not possible
    //a.priv(); //not possible
  }

  function callThisFunctions() external {
    this.pub();
    this.extl();
    //a.intl(); //not possible
    //a.priv(); //not possible
  }
}

contract B {
  A public a;

  function callExternalFunctions() external {
    a = new A();
    a.pub();
    a.extl();
    //a.intl();
    //a.priv();
  }
}

contract C is A {
  function callInheritableFunctions() external {
    pub();
    //extl(); //not possible
    intl();
    //priv(); //not possible
  }
}