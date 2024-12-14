// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract DataLocation {
    uint[10] public staticArray;

    constructor() {
        for (uint x = 0; x < 10; x++) {
            uint y = x + 1;
            staticArray[x] = y;
        }
    }

    function setValueThroughMemory(uint position, uint newValue) external {
        uint[10] memory memoryArray = staticArray;
        memoryArray[position] = newValue;
        staticArray = memoryArray;
    }

    function setValueThroughStorage(uint position, uint newValue) external {
        uint[10] storage memoryArray = staticArray;
        memoryArray[position] = newValue;
        staticArray = memoryArray;
    }

    function setValueThroughStorageSimplified(uint position, uint newValue) external {
        uint[10] storage memoryArray = staticArray;
        memoryArray[position] = newValue;
    }
}