// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.30;

contract A {
    uint public a;

    function set(uint x) external virtual {
        setA(x);
    }

    function setA(uint x) internal virtual {
        a = x;
    }
}

contract B is A {
    uint public b;

    //'external' can become 'public', but 'public' cannot change
    function set(uint x) public virtual override {
        setA(x);
        setB(x);
    }

    //'internal' cannot become 'public' or 'private'
    function setA(uint x) internal virtual override {
        a = x + 1;
    }

    //a 'private' function cannot be 'virtual'
    function setB(uint y) private /*virtual*/ {
        b = y;
    }
}

contract C is B {
    uint public c;

    function set(uint x) public override {
        setA(x);
        //not possible because setB is private
        //setB(x);
        setC(x);
    }

    function setInternal(uint x) external {
        //only works, because 'set' is 'internal' (or 'public')
        B.set(x); //calls 'set' from 'B', but 'setA' from 'C'

        //does not work, because 'set' is 'external'
        //A.set(x);

        //alternative for direct parent,
        //only works because 'set' is 'internal' (or 'public')
        //super.set(x);

        setC(x);
    }

    function setExternal(uint x) external {
        //calls C.set(x) instead of B.set(x)
        B b = this;
        b.set(x);
    }

    //is not 'virtual', cannot be overriden anymore
    function setA(uint x) internal override {
        a = x + 2;
    }

    //is not 'virtual', cannot be overridden
    function setC(uint z) internal {
        c = z;
    }
}
