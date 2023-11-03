// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressExample {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getBalance(address account) public view returns (uint256) {
        return account.balance;
    }

    function getCode(address contractAddress) public view returns (bytes memory) {
        return contractAddress.code;
    }

    function getCodeHash(address contractAddress) public view returns (bytes32) {
        return contractAddress.codehash;
    }

    function sendEther(address payable recipient, uint256 amount) public {
        require(msg.sender == owner, "Only the contract owner can send Ether");
        recipient.send(amount);
    }
}
