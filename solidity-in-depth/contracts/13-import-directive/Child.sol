// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

import './Parent.sol' as trunk;
//import './Parent.sol' as trunk.branch; //'.' not allowed in identifier

contract Child is trunk.root.GrandParent, trunk.Parent {}