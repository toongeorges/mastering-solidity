// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

abstract contract Parent {
    //abstract classes can have abstract modifiers
    modifier owner() virtual;
}

//pure abstract class
interface I /*is Parent*/ { //cannot inherit from contracts
    //nested type definitions are possible like under contracts
    enum E { A, B, C }
    struct S { uint x; }

    //cannot have state variables
    //uint i;

    //cannot have a constructor or be instantiated
    //constructor() {}

    //can only have 'external' functions
    //function a() private;
    //function b() internal;
    function c() external; //Interface functions are implicitly "virtual"
    //function d() public;

    //cannot have function definitions, only declarations
    //function e() external {}

    //cannot have modifiers
    //modifier owner() virtual;
    //modifier owner() {}
}

interface J is I {} //interfaces can inherit from interfaces

contract K is J {
    E public e;   //type E can be accessed as E, I.E, J.E or K.E
    J.S public s; //type S can be accessed as S, I.S, J.S or K.S

    //'override' is optional when inheriting from interfaces
    function c() external override {
        e = E.C;
        s = S(1);
    }
}
