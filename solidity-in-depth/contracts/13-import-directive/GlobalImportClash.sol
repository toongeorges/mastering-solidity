// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

import './GlobalDefinition1.sol';
//import './GlobalDefinition2.sol';              //does not work
import './GlobalDefinition2.sol' as alternative; //works, because another namespace

