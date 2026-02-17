// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.33;

import { Father, Mother as Mom } from './SpecificImported.sol';
//contract Father {}
//contract Mom {}

contract Son is Father, Mom {} //but not Mother or HolySpirit
