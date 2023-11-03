// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnitConversionExample {
    // Function to convert Ether to Wei and Gwei
    function etherToWeiAndGwei(uint256 etherAmount) public pure returns (uint256, uint256) {
        // Convert Ether to Wei (1 Ether = 10^18 Wei)
        uint256 weiAmount = etherAmount * 1 ether; // 1 Ether is equal to 10^18 Wei

        // Convert Wei to Gwei (1 Gwei = 10^9 Wei)
        uint256 gweiAmount = weiAmount / 1 gwei; // 1 Gwei is equal to 10^9 Wei

        return (weiAmount, gweiAmount);
    }
}
