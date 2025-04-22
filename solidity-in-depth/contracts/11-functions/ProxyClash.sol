// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

//See https://ethereum.stackexchange.com/questions/70987/proxy-function-clashing-what-kind-of-danger-comes-exactly-with-it
//for context

//See https://medium.com/nomic-foundation-blog/malicious-backdoors-in-ethereum-proxies-62629adf3357
//and https://forum.openzeppelin.com/t/beware-of-the-proxy-learn-how-to-exploit-function-clashing/1070
// for other examples

contract A {
    //function selector: 0x3fa4f245
    int public value;

    //function selector: 0xd826f88f
    function reset() external {
        value = 0;
    }

    //function selector: 0x025313a2
    function proxyOwner() external {
        value = 1;
    }

    //function selector: 0x8679b0c0
    function forbidden() external {
        value = 2;
    }

    //function selector: 0x025313a2
    //compiler detects clash
    //function clash550254402() external {
    //    value = 2;
    //}

    //This function is just there to please Remix when calling 'Transact',
    //it is not required for non-Remix interactions
    fallback() external {}
}

contract B is A {
    //function selector: 0x025313a2
    //compiler detects clash
    //function clash550254402() external {
    //    value = 2;
    //}
}

contract Proxy {
    A a;

    constructor(address addr) {
        a = A(addr);
    }

    //function selector: 0x3fa4f245
    function value() external view returns (int) {
        return a.value();
    }

    fallback() external payable {
        address addr = address(a);

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := call(gas(), addr, 0, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())

            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {}
}

//DO NOT USE PROXIES
//Use libraries or ENS instead, depending on your needs
contract EvilProxy is Proxy {
    constructor(address addr) Proxy(addr) {}

    //function selector: 0x025313a2
    //compiler does not detect clash
    function clash550254402() external {
        //replace the a.proxyOwner() function call with the a.forbidden() function call
        a.forbidden();
    }
}

contract CleanProxy {
    A a;

    constructor(address addr) {
        a = A(addr);
    }

    //function selector: 0x3fa4f245
    function value() external view returns (int) {
        return a.value();
    }

    //function selector: 0xd826f88f
    function reset() external {
        a.reset();
    }

    //function selector: 0x025313a2
    function proxyOwner() external {
        a.proxyOwner();
    }

    //function selector: 0x025313a2
    //compiler detects clash
    /*
    function clash550254402() external {
    }
    */
}
