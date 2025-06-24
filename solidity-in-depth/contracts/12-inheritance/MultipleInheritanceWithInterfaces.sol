// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

interface I {
    function f() external;
}

interface J {
    function f() external;
}

interface K {
    function f() external;
}

interface SingleInheritance1 is I {
}

interface SingleInheritance2 is I {
    function f() external; //optional with single inheritance
}

interface SingleInheritance3 is I {
    function f() external override; //optional with single inheritance
}

interface SingleInheritance4 is I {
    function f() external override(I); //optional with single inheritance
}

interface MultipleInheritance is I, J, K {
    function f() external override(I, J, K); //required with multiple inheritance
}