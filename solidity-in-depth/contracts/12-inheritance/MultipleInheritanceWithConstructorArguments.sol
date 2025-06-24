// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

/* Vehicle------------\-------------\
 * ||                 |             |
 * |PassengerVehicle  CargoVehicle  AirCraft--------------\-----------\
 * ||                 |             |  |                  |           |
 * ||                 |             |  FixedWingAircraft  Rotorcraft  Airship
 * ||                 |             |  |
 * Plane--------------/-------------/--/      
 */
contract Vehicle {
    constructor(uint x, address y, bool z) {}
}

//constant values after 'is'
contract Aircraft is Vehicle(1, 0x0000000000000000000000000000000000000000, false) {
    constructor() {}
}

contract FixedWingAircraft is Aircraft {
    constructor() {}
}

contract Rotorcraft is Aircraft {
    constructor(uint x) {}
}

contract Airship is Aircraft {
    constructor(address a) {}
}

contract PassengerVehicle is Vehicle {
    //ancestor constructor arguments taken from constructor arguments
    constructor(uint x, address y, bool z, int u) Vehicle(x, y, z) {}
}

contract CargoVehicle is Vehicle {
    //ancestor constructor arguments calculated from constructor arguments
    constructor(address a, uint b, uint c) Vehicle(b + c, a, b < c) {}
}

//not possible because 'Vehicle' (inherited multiple times) has a constructor with arguments
/*
contract Plane is Vehicle, PassengerVehicle, CargoVehicle, Aircraft, FixedWingAircraft {
    constructor(address a, address b, address c, bool d, int e)
    //Vehicle(1, a, d)
    PassengerVehicle(2, b, false, e) 
    CargoVehicle(c, 3, 0) 
    //Aircraft() 
    //FixedWingAircraft()
    {}
}
*/

//not possible because 'Vehicle' (inherited multiple times) has a constructor with arguments
/*
contract Train is PassengerVehicle, CargoVehicle {
    constructor(address a) PassengerVehicle(1, a, false, 2) CargoVehicle(a, 1, 0) {}
}
*/

//possible because 'Aircraft' (inherited multiple times) has a no-arg constructor
contract RotorPlaneBalloon is Aircraft, FixedWingAircraft, Rotorcraft, Airship {
    constructor(uint x, address a) Rotorcraft(x) Airship(a) {}
}

contract A {
    constructor(/*uint x*/) {}
}

contract B is A(/*1*/) {}

contract C is A(/*1*/) {}

//only possible because 'A' (inherited multiple times) has a no-arg constructor
contract D is B, C {}