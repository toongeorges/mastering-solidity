// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//see https://docs.soliditylang.org/en/stable/contracts.html#return-variables
contract C {
    //TypeError: Data location must be "memory" or "calldata" for parameter in external function,
    //but "storage" was given.
    /*
    function returnMapping(mapping(uint => uint) storage m) external pure returns (mapping(uint => uint) storage) {
        return m;
    }
    */

    function _returnMapping(mapping(uint => uint) storage m) internal pure returns (mapping(uint => uint) storage) {
        return m;
    }

    //TypeError: Internal type is not allowed for public or external functions.
    /*
    function returnInternalFunction(function() internal f) external pure returns (function() internal) {
        return f;
    }
    */

    function _returnInternalFunction(function() internal f) internal pure returns (function() internal) {
        return f;
    }

    //TypeError: Data location must be "memory" or "calldata" for parameter in external function,
    //but "storage" was given.
    /*
    function returnStorageVariable(string storage s) external pure returns (string storage) {
        return s;
    }
    */

    function _returnStorageVariable(string storage s) internal pure returns (string storage) {
        return s;
    }
}


library L {
    function returnMapping(mapping(uint => uint) storage m) external pure returns (mapping(uint => uint) storage) {
        return m;
    }

    function _returnMapping(mapping(uint => uint) storage m) internal pure returns (mapping(uint => uint) storage) {
        return m;
    }

    //TypeError: Internal type is not allowed for public or external pure functions.
    /*
    function returnInternalFunction(function() internal f) external pure returns (function() internal) {
        return f;
    }
    */

    function _returnInternalFunction(function() internal f) internal pure returns (function() internal) {
        return f;
    }

    function returnStorageVariable(string storage s) external pure returns (string storage) {
        return s;
    }

    function _returnStorageVariable(string storage s) internal pure returns (string storage) {
        return s;
    }
}