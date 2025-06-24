// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

abstract contract AbstractParent {
    uint public a;
    uint public b;
    uint public c;

    modifier doSomethingElse virtual;

    function reset() external {
        a = 0;
        b = 0;
        c = 0;
    }

    function setA(uint x) external doSomethingElse virtual {
        a = x;
    }

    function setB(uint x) external virtual {
        b = x;
    }

    function setC(uint x) external doSomethingElse virtual {
        c = x;
    }
}

contract Child is AbstractParent {
    modifier doSomethingElse override virtual {
        if (false) {
            _; //never executed, a modifier needs to contain '_'
        } else {
            a = 1;
            b = 1;
            c = 1;
        }
    }

    function setB(uint x) external doSomethingElse override {
        b = x;
    }

    function setC(uint x) external override {
        c = x;
    }
}

contract GrandChild is Child {
    modifier doSomethingElse override virtual {
        if (false) {
            _; //never executed, a modifier needs to contain '_'
        } else {
            a = 2;
            b = 2;
            c = 2;
       }
    }
}