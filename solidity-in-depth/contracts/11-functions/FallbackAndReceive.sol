// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//calldata that does not call the function 'fallback' or 'receive' will fail
contract FakeFallbackAndReceive {
    uint public invocations;

    //a function can have the identifier 'fallback',
    //this is not the fallback function!
    //You will get a compiler warning.
    function fallback() external {
        invocations++;
    }

    //a function can have the identifier 'receive',
    //this is not the receive function!
    //You will get a compiler warning.
    function receive() external {
        invocations++;
    }
}

contract FallbackAndReceive {
    uint public invocations;
    bool public fback;
    bool public rcve;
    bool public fake;

    //a function can have the identifier 'fallback',
    //this is not the fallback function!
    //You will get a compiler warning.
    function fallback() external {
        invocations++;
        fback = false;
        rcve = false;
        fake = true;
    }

    //a function can have the identifier 'receive',
    //this is not the receive function!
    //You will get a compiler warning.
    function receive() external {
        invocations++;
        fback = false;
        rcve = false;
        fake = true;
    }

    //must be external and cannot be pure or view
    //
    //Fallback function either has to have the signature 
    //"fallback()" or "fallback(bytes calldata) returns (bytes memory)"
    //
    //Only executed when calldata is not empty, even if money is sent.
    //If money is sent, the transaction will be reverted,
    //because 'fallback' is non-payable
    fallback() external {
        invocations++;
        fback = true;
        rcve = false;
        fake = false;
    }

    //must be external and payable,
    //cannot have arguments or return value
    //
    //Only executed when calldata is empty, even if no money is sent
    receive() external payable {
        invocations++;
        fback = false;
        rcve = true;
        fake = false;
    }
}

//only works if calldata is empty
contract OnlyReceive {
    uint public invocations;

    receive() external payable {
        invocations++;
    }
}

//works also if calldata is empty
//
//if we make 'fallback' payable,
//we get a warning to also add 'receive'
contract OnlyFallback {
    uint public invocations;

    //Fallback function either has to have the signature 
    //"fallback()" or "fallback(bytes calldata) returns (bytes memory)"
    fallback(bytes calldata x) external payable returns (bytes memory) {
        invocations++;
        return x;
    }
}