// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

/* Vehicle ---------\-----------------\-------------\--\
 * |                |                 |             |  |
 * PersonalVehicle  PassengerVehicle  CargoVehicle-\|/-Aircraft--------------\-----------\
 * | /--------------/  |    |      \--|--|--------\|||    |                  |           |
 * | |                 |    |   /-----/  |        ||||/---FixedWingAircraft  Rotorcraft  Airship
 * | |                 |    |   |        |        |||||  
 * Car                 Bus  Train        Truck    Plane
 */
contract Vehicle {
    uint public x;

    function speedUp() external virtual { x = 1; }
    function slowDown() external virtual { x = 1; }
}

contract Aircraft is Vehicle {
    function speedUp() external override virtual { x = 2; }
    function slowDown() external override virtual { x = 2; }
}

contract FixedWingAircraft is Aircraft {}

contract Rotorcraft is Aircraft {}

contract Airship is Aircraft {}

contract PersonalVehicle is Vehicle {
    function speedUp() public override virtual { x = 3; }
}

contract PassengerVehicle is Vehicle {
    function speedUp() public override virtual { x = 4; }
    function slowDown() public override virtual { x = 4; }
}

contract CargoVehicle is Vehicle {
    function speedUp() public override virtual { x = 5; }
    function slowDown() public override virtual { x = 5; }
}

contract Car is PersonalVehicle, PassengerVehicle {
    //override of multiple inherited functions required!
    function speedUp() public override(PersonalVehicle, PassengerVehicle) virtual {
        PersonalVehicle.speedUp(); //only possible because PassengerVehicle.speedUp() is public or internal
    }
    function slowDown() public override(PassengerVehicle, Vehicle) virtual {
        PassengerVehicle.slowDown(); //only possible because PersonalVehicle.slowDown() is public or internal
    }
}

contract Bus is PassengerVehicle {
    /* override not required
    function speedUp() public override virtual {}
    function slowDown() public override virtual {}
    */
}

contract Train is PassengerVehicle, CargoVehicle {
    //override of multiple inherited functions required!
    function speedUp() public override(PassengerVehicle, CargoVehicle) virtual {
        super.speedUp();
    }
    function slowDown() public override(PassengerVehicle, CargoVehicle) virtual {
        super.slowDown();
    }
}

// Partial ordering where base classes have to appear first:
// Vehicle before anything else, Aircraft before FixedWingAirCraft
contract Plane is Vehicle, PassengerVehicle, CargoVehicle, Aircraft, FixedWingAircraft {
    //only ancestor classes with the function definition are listed, order in listing does not matter
    function speedUp() public override(PassengerVehicle, CargoVehicle, Aircraft, Vehicle) virtual {}
    function slowDown() public override(Vehicle, Aircraft, PassengerVehicle, CargoVehicle) virtual {}
}

contract Truck is CargoVehicle {}

