// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract A {
    uint public a;

    //needs to be 'virtual', otherwise the function cannot be overridden
    function set(uint x) external virtual {
        a = x;
    }

    //needs to be 'virtual', otherwise the function cannot be overridden
    function multiply() external virtual {
        a = 2*a;
    }
}

contract B is A {
    //needs to use 'override'
    function set(uint x) external virtual override {
        a = x + 1;
    }

    //needs to use 'override'
    function multiply() external override {
        a = 3*a;
    }
}

contract C is B {
    //needs to use 'override'
    function set(uint x) external override {
        a = x + 2;
    }

    /* cannot be overridden, because the function in B is not 'virtual'
    function multiply() external override {
        a = 5*a;
    }
    */
}
