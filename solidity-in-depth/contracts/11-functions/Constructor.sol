// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

abstract contract Base {
  uint public a;

  //Constructors can be 'payable' or non-payable, but not 'view' or 'pure'.
  //The visibility of constructors is ignored,
  //constructors of abstract contracts are 'internal',
  //constructors of non-abstract contracts are 'public'
  constructor(uint x) payable /*internal*/ {
    a = x;
  }    

  /* only 1 constructor can be defined, overloading is not allowed
  constructor() {
    a = 0;
  }
  */
}

contract Constructor is Base {
  uint public b;

  //A constructor is executed when a new instance of a smart contract is created.
  //A constructor is like a function,
  //except it uses the keyword 'constructor',
  //it does not return values,
  //and it cannot be overridden, but must be called by child contracts,
  //using the name of the base contract like a modifier
  constructor(uint x, uint y) Base(x) /*public*/ {
    b = y;
  }
}
