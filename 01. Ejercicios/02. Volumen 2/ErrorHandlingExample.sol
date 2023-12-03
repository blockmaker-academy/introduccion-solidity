// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ErrorHandlingExample {
    function divide(uint256 numerator, uint256 denominator) public pure returns (uint256, string memory) {
        // Ensure that the denominator is not zero
        require(denominator != 0, "Division by zero is not allowed");

        // Perform the division
        uint256 result = numerator / denominator;

        // Return the result and a success message
        return (result, "Division successful");
    }
}
