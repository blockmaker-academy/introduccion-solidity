// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StringConcatExample {
    function concatenateStrings(string memory str1, string memory str2, string memory str3) public pure returns (string memory) {
        // Concatenate the three strings using string.concat
        string memory result = string.concat(str1, str2, str3);
        return result;
    }
}