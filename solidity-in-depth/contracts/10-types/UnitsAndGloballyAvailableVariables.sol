// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Units {
    function getEtherUnits() public pure returns (uint, uint, uint) {
        return (1 wei, 1 gwei, 1 ether);
    }

    function getDayUnits() public pure returns (uint, uint, uint, uint, uint) {
        return (1 seconds, 1 minutes, 1 hours, 1 days, 1 weeks);
    }
}

contract GloballyAvailableVariables {
    function getBlockVariables() public view returns
    (uint, uint, uint, address payable, uint, uint, uint, uint, bytes32) {
        return (
            block.basefee,
            block.blobbasefee,
            block.chainid,
            block.coinbase,
            block.gaslimit,
            block.number,
            block.prevrandao,
            block.timestamp,
            blockhash(block.number) //or any other of the last 256 block numbers
        );
    }

    function getBlobVersionedHashes() public view returns
    (bytes32, bytes32, bytes32, bytes32, bytes32, bytes32) {
        return (
            blobhash(0),
            blobhash(1),
            blobhash(2),
            blobhash(3),
            blobhash(4),
            blobhash(5)
        );
    }

    function getMessageVariables() public view returns
    (bytes calldata, address, bytes4/*, uint*/) {
        return (
            msg.data,
            msg.sender,
            msg.sig/*,
            msg.value*/ // msg.value requires the function to be 'payable' instead of 'view'.
                        // A non-'view' or non-pure' function does not return values, but transaction data.
                        // Events have to be used for a 'payable' function to retrieve output data.
        );
    }

    function getTransactionVariables() public view returns (uint, address, uint) {
        return (
            tx.gasprice,
            tx.origin,
            gasleft()
        );
    }
}