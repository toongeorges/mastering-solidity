// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.26;

contract DeleteArrays {
    uint[] values;

    function size() external view returns (uint) {
        return values.length;
    }

    function add(uint value, uint count) external {
        for (uint i = 0; i < count; i++) {
            values.push(value);
        }
    }

    function deleteArray() external {
        delete values;
    }
}