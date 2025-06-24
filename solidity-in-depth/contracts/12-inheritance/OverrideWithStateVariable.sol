// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract A {
    uint public a;

    function set(uint x) public virtual {
        a = x;
    }

    function b() external view virtual returns (uint) {
        return 1;
    }

    function c() internal view virtual returns (uint) {
        return 2;
    }

    function d() public view virtual returns (uint) {
        return 3;
    }
}

contract B is A {
    function set(uint x) public override {
        super.set(x);
        b = x;
    }

    //DeclarationError: Identifier already declared.
    /*
    function a() external view override returns (uint) {
        return 0;
    }
    */

    //TypeError: Overriding public state variable is missing "override" specifier.
    //uint public b;
    //'public' state variables override functions with the same name and return type (automatically generated getter)
    uint public override b;

    //DeclarationError: Identifier already declared.
    //uint internal c;
    //'internal' state variables do not override functions with the same name (no automatically generated getter)
    //uint internal override c;

    //TypeError: Public state variables can only override functions with external visibility.
    //uint public override d;
}
