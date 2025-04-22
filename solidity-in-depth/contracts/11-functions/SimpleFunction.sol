// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract SimpleFunction {
    uint public counter;

    function increment() external {
        counter++;
    }
}