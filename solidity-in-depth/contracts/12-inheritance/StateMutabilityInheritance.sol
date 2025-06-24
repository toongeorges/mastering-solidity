// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract Parent {
    uint internal value;

    function calculate(uint x) external pure virtual returns (uint) {
        return x;
    }

    function read() external view virtual returns (uint) {
        return value;
    }

    function write(uint x) external virtual {
        value = x;
    }

    function earn() external payable virtual {}
}

contract PureChild is Parent {
    function calculate(uint x) external pure override returns (uint) {
        return x;
    }

    function read() external pure override returns (uint) {
        return 0;
    }

    function write(uint x) external pure override {
    }

//cannot remove 'payable'
//    function earn() external pure override {}
}

contract ViewChild is Parent {
    /* from 'pure' to 'view' (less restrictive): not allowed
    function calculate(uint x) external view override returns (uint) {
        return x;
    }
    */

    function read() external view override returns (uint) {
        return value;
    }

    function write(uint x) external view override {
    }

//cannot remove 'payable'
//    function earn() external view override {}
}

contract NonPayableChild is Parent {
    /* from 'pure' to 'non-payable' (less restrictive): not allowed
    function calculate(uint x) external override returns (uint) {
        return x;
    }
    */

    /* from 'view' to 'non-payable' (less restrictive): not allowed
    function read() external override returns (uint) {
        return value;
    }
    */

    function write(uint x) external override {
        value = x;
    }

//cannot remove 'payable'
//    function earn() external override {}
}

contract PayableChild is Parent {
    /* cannot add 'payable'
    function calculate(uint x) external payable override returns (uint) {
        return x;
    }
    */

    /* cannot add 'payable'
    function read() external payable override returns (uint) {
        return value;
    }
    */

    /* cannot add 'payable'
    function write(uint x) external payable override {
        value = x;
    }
    */

    function earn() external payable override {}
}
