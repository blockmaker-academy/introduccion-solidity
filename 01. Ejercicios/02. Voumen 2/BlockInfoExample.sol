// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockInfoExample {
    event Info(
        uint256 basefee,
        uint256 chainid,
        address payable coinbase,
        uint256 gaslimit,
        uint256 number,
        uint256 timestamp,
        address sender,
        uint256 value,
        uint256 gasprice,
        address origin
    );

    function printBlockAndTransactionInfo() public payable {
        emit Info(
            block.basefee,
            block.chainid,
            block.coinbase,
            block.gaslimit,
            block.number,
            block.timestamp,
            msg.sender,
            msg.value,
            tx.gasprice,
            tx.origin
        );
    }
}
