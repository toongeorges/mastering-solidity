// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

//abstract contracts can have unimplemented 'virtual' methods
abstract contract A {
    uint public a;

    //abstract classes can have a constructor,
    //but cannot be instantiated (unless from an inheriting class)
    constructor(uint x) {
        a = x;
    }


    //abstract function declaration, without definition
    //the visibility cannot be 'private', since 'private' functions cannot be overridden
    //function doNothing(uint x) private view virtual returns (uint);

    //abstract function declaration, without definition
    //must be 'virtual', so it can be overridden with an implementation
    function add(uint x) internal view virtual returns (uint);

    //abstract function declaration, without definition
    //must be 'virtual', so it can be overridden with an implementation
    function multiply(uint x) external view virtual returns (uint);

    //abstract function declaration, without definition
    //must be 'virtual', so it can be overridden with an implementation
    function addMultiply(uint x) public view virtual returns (uint);
}

//non-abstract contracts cannot have unimplemented methods
contract AA is A {
    constructor(uint x) A(x) {}

    //implemented abstract functions need to contain the keyword 'override'
    function add(uint x) internal view override virtual returns (uint) {
        return a + x;
    }

    //implemented abstract functions need to contain the keyword 'override'
    function multiply(uint x) external view override virtual returns (uint) {
        return a * x;
    }

    //implemented abstract functions need to contain the keyword 'override'
    function addMultiply(uint x) public view override virtual returns (uint) {
        return a * (a + x);
    }
}

//abstract contracts can inherit from normal contracts
abstract contract AAA is AA {
    //abstract contracts are not required to initialize ancestor constructors
    //constructor(uint x) AA(x) {}

    //abstract contracts are not required to have abstract methods

    //an overridden 'virtual' function with an implementation cannot be made abstract
    //function add(uint x) internal view override virtual returns (uint);
}

contract AAAA is AAA {
    //if an abstract class did not initialize an ancestor constructor,
    //non-abstract inheriting classes have to initialize the constructor
    constructor(uint x) AA(x) {}
}