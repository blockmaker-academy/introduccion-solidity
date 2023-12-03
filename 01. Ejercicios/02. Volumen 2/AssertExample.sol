// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssertExample {
    function doSomething(uint256 x, uint256 y) public pure returns (uint256) {
        // Ensure that x is less than y using assert
        assert(x < y);

        // Perform some other operations
        uint256 result = y - x;

        return result;
    }
}
