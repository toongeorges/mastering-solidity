// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

/* Vehicle----\-----------------\
 * ||         |                 |
 * |Aircraft  PassengerVehicle  CargoVehicle
 * |||                  |       |
 * ||FixedWingAircraft  |       |
 * |||                  |       |
 * PlaneX---------------/-------/      
 */
contract Vehicle {
    uint public v;

    constructor() {
        v = v*10 + 1;
    }
}

contract Aircraft is Vehicle {
    constructor() {
        v = v*10 + 4;
    }
}

contract FixedWingAircraft is Aircraft {
    constructor() {
        v = v*10 + 5;
    }
}

contract PassengerVehicle is Vehicle {
    constructor() {
        v = v*10 + 2;
    }
}

contract CargoVehicle is Vehicle {
    constructor() {
        v = v*10 + 3;
    }
}

// Partial ordering where base classes have to appear first:
// Vehicle before anything else, Aircraft before FixedWingAirCraft
contract Plane1 is Vehicle, PassengerVehicle, CargoVehicle, Aircraft, FixedWingAircraft {
}

//The order in the list after 'is' determines the linearization order,
//this can be verified with the storage location of the state variables.
contract Plane2 is Vehicle, Aircraft, PassengerVehicle, FixedWingAircraft, CargoVehicle {
}

contract Plane3 is Vehicle, PassengerVehicle, CargoVehicle, Aircraft, FixedWingAircraft {
    //listing order of ancestor constructors after constructor does not change order of execution
    constructor() Aircraft() CargoVehicle() PassengerVehicle() {}
}

