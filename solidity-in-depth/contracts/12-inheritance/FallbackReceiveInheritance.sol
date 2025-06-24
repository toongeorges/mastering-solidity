// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

abstract contract AbstractParent {
    fallback() external virtual;
    receive() external payable virtual;
}

contract Child is AbstractParent {
    uint public x;

    fallback() external override virtual {
        x = 1;
    }

    receive() external payable override virtual {
        x = 1;
    }
}

contract GrandChild is Child {
    fallback() external override virtual {
        x = 2;
    }

    receive() external payable override virtual {
        x = 2;
    }
}

interface I {
    fallback() external;
    receive() external payable;
}