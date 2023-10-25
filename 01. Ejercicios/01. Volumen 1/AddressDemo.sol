// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressDemo {
    address public nonPayableAddress;
    address payable public payableAddress;

    constructor() {
        nonPayableAddress = msg.sender;
        payableAddress = payable(msg.sender); // Use the contract's address
    }

    // Function to receive Ether
    receive() external payable {}

    // Function to check the balance of an address
    function getBalance(address _address) public view returns (uint) {
        return _address.balance;
    }

    // Function to send Ether (only callable by payableAddress)
    function sendEther(uint amount) public {
        require(msg.sender == payableAddress, "Only payableAddress can send Ether");
        payableAddress.transfer(amount);
    }
}
