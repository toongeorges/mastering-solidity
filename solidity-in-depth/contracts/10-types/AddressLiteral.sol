// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract AddressLiteral {
    uint152 x = 0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3;
    //this does not work, for uint152 no 0x00 byte can be added in front
    //uint152 x2 = 0x00dCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3;

    address y = 0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AF;
    //a hexadecimal literal of 20 bytes is always interpreted as an address
    //it cannot be interpreted as a uint160 
    //uint160 y2 = 0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AF;
    //add an extra 0x00 byte in front to allow a hexadecimal literal to be a uint160
    uint160 y3 = 0x00dCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AF;

    uint168 z = 0xdCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AFff;
    //for uint160, uint168 and up you can add extra 0x00 bytes in front
    uint168 z2 = 0x00dCad3a6d3569DF655070DEd06cb7A1b2Ccd1D3AFff;
}
