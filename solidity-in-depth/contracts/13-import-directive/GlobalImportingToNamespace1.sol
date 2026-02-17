// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

import './GlobalImported.sol' as imported;
//import "./GlobalImported.sol" as imported; //using the same namespace twice causes an error

contract SimpleContract is imported.A, imported.B { //use contract and interface
    uint x;

    function simpleFunction() external {
        imported.C.c();                            //use library
        imported.d();                              //use global function
        x = imported.E;                            //use constant value
        x = imported.F(1).x;                       //use global struct
        x = uint(imported.G.ONE);                  //use global enum
        x = imported.H.unwrap(imported.H.wrap(2)); //use global user defined value type
    }

    function throwError() pure external {
        revert imported.I();                       //use global error
    }

    function emitEvent() external {
        emit imported.J();                         //use global event
    }
}
