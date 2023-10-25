// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingExample {
    // Define a mapping that associates addresses with balances
    mapping(address => uint256) public balances;

    // Function to set the balance for an address
    function setBalance(address _account, uint256 _balance) public {
        balances[_account] = _balance;
    }

    // Function to get the balance of an address
    function getBalance(address _account) public view returns (uint256) {
        return balances[_account];
    }
}
