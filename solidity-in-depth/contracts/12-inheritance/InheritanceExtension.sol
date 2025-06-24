// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract A {
    uint public a;

    function setA(uint x) external {
        a = x;
    }
}

contract B is A {
    uint public b;

    function setB(uint y) external {
        b = y;
    }
}

contract C is B {
    uint public c;

    function setC(uint z) external {
        c = z;
    }
}
