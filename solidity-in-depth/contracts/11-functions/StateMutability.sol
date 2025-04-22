// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract StateMutability {
    uint public value;

    function doubleArgument(uint x) external pure returns (uint) {
        return 2*x;
    }

    function doubleValue() external view returns (uint) {
        return 2*value;
    }

    function writeValue(uint x) external {
        value = x;
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function collect() external payable {
        value = this.getBalance();
    }
}
