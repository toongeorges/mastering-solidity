// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

// See https://docs.soliditylang.org/en/stable/style-guide.html#order-of-layout
// for order of import directive

import './GlobalImported.sol'; //both '' and "" can be used to import
import "./GlobalImported.sol"; //importing the same file twice causes no error

contract SimpleContract is A, B { //use contract and interface
    uint x;

    function simpleFunction() external {
        C.c();                   //use library
        d();                     //use global function
        x = E;                   //use constant value
        x = F(1).x;              //use global struct
        x = uint(G.ONE);         //use global enum
        x = H.unwrap(H.wrap(2)); //use global user defined value type
    }

    function throwError() pure external {
        revert I();              //use global error
    }

    function emitEvent() external {
        emit J();                //use global event
    }
}
