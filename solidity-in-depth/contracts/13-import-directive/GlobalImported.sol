// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

/* all the possible global definitions */

contract A {}                          //smart contract
interface B {}                         //interface
library C { function c() internal {} } //library
function d() {}                        //global function
uint constant E = 1;                   //constant variable declaration
struct F { uint x; }                   //global struct definition
enum G { ZERO, ONE }                   //global enum definition
type H is uint;                        //global user defined value type definition
error I();                             //global error definition
event J();                             //global event definition
