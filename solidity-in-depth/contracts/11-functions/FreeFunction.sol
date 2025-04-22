// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//Free functions cannot have visibility.
//
//Free functions behave implicitly as internal functions
//in the contracts that use them.
//Multiple contracts can reuse them,
//however they have no access to:
//  - 'this'
//  - storage variables
//  - non-free functions
function inc(uint value) pure returns (uint) {
    //no access to storage variable
    //counter++;

    //no access to non-free function
    //increment();

    return value + 1;
}

contract FreeFunction {
    uint public counter;

    function increment() external {
        counter = inc(counter);
    }
}