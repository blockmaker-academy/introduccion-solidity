// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathCryptoExample {
    function safeAdd(uint256 a, uint256 b, uint256 k) public pure returns (uint256) {
        // Safely add a and b, then take the modulo k
        return addmod(a, b, k);
    }

    function safeMultiply(uint256 a, uint256 b, uint256 k) public pure returns (uint256) {
        // Safely multiply a and b, then take the modulo k
        return mulmod(a, b, k);
    }

    function calculateKeccak256(bytes memory data) public pure returns (bytes32) {
        // Calculate the Keccak-256 hash of the data
        return keccak256(data);
    }
}
