// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TernaryExample {
    // Function to determine if an age is eligible for voting
    function isEligibleForVoting(uint256 age) public pure returns (string memory) {
        string memory result = (age >= 18) ? "Eligible for voting" : "Not eligible for voting";
        return result;
    }
}