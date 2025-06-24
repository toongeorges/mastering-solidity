// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract A {
    uint public a;

    function set(uint x) external virtual {
        a = x;
    }
}

contract B is A {
    function set(uint x) external override {
        a = x + 1;
    }
}
