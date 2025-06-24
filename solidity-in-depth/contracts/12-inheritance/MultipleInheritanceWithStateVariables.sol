// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

/* Vehicle ---------\-----------------\-------------\--\
 * |                |                 |             |  |
 * PersonalVehicle  PassengerVehicle  CargoVehicle-\|/-Aircraft--------------\-----------\
 * | /--------------/  |    |      \--|--|--------\|||    |                  |           |
 * | |                 |    |   /-----/  |        ||||/---FixedWingAircraft  Rotorcraft  Airship
 * | |                 |    |   |        |        |||||  
 * Car                 Bus  Train        Truck    PlaneX      
 */
contract Vehicle {
    uint public a;

    function setA(uint x) external {
        a = x;
    }
}

contract Aircraft is Vehicle {
    uint public d;

    function setD(uint x) external {
        d = x;
    }
}

contract FixedWingAircraft is Aircraft {
    uint public e;

    function setE(uint x) external {
        e = x;
    }
}

contract Rotorcraft is Aircraft {}

contract Airship is Aircraft {}

contract PersonalVehicle is Vehicle {}

contract PassengerVehicle is Vehicle {
    uint public b;

    function setB(uint x) external {
        b = x;
    }
}

contract CargoVehicle is Vehicle {
    //name cannot be 'a', because 'a' is already used in parent class
    //name cannot be 'b', because 'b' is already used in sibling class in multiple inheritance hierarchy
    uint public c;

    //name cannot be 'setA', because 'setA' is already used in parent class
    //name cannot be 'setB', because 'setB' is already used in sibling class in multiple inheritance hierarchy
    function setC(uint x) external {
        c = x;
    }
}

contract Car is PersonalVehicle, PassengerVehicle {}

contract Bus is PassengerVehicle {}

contract Train is PassengerVehicle, CargoVehicle {}

// Partial ordering where base classes have to appear first:
// Vehicle before anything else, Aircraft before FixedWingAirCraft
contract Plane1 is Vehicle, PassengerVehicle, CargoVehicle, Aircraft, FixedWingAircraft {}

//The order in the list after 'is' determines the linearization order,
//this can be verified with the storage location of the state variables.
contract Plane2 is Vehicle, Aircraft, PassengerVehicle, FixedWingAircraft, CargoVehicle {}

contract Truck is CargoVehicle {}

