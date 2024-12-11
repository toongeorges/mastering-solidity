// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Parent {
    function y() external view virtual returns (uint) {
        return 0;
    }
}

contract StateVariableDeclaration is Parent {
    uint public constant COMBINED = 7;

    // all data is always visible on the blockchain,
    // but accessibility by code can be restricted
    uint accessibility1;          //default accessibility = internal accessibility
    uint public accessibility2;   //accessible by all code on the blockchain
    uint private accessibility3;  //accessible only by code in this smart contract
    uint internal accessibility4; //accessible only by code in this or inheriting smart contracts

    // mutable or immutable data
    uint variable;          //value of variable can change
    uint constant ONE = 1;  //value of ONE is constant, the value must be declared here
    uint public immutable TWO = 2; //value of TWO is constant, the value is either declared here or in the constructor

    constructor() {
        // TypeError: Cannot assign to a constant variable.
        //ONE = 2;
        TWO = 3;
    }

    /* TypeError: Cannot write to immutable here:
     * Immutable variables can only be initialized inline or assigned directly in the constructor.
    function changeTWO() external {
        TWO = 4;
    }
     */

    // TypeError: Override can only be used with public state variables.
    // uint override x;
    uint public override y = 2;

    // data location of a state variable
    uint storageVar;             //by default, the value is stored permanently on the blockchain
    /* currently gives: UnimplementedFeatureError: Transient storage variables are not supported.
    uint transient transientVar; //transient storage is only stored within this transaction (and is cheaper)
     * see https://solidity-by-example.org/transient-storage/ for transient storage through YUL
     */
}
