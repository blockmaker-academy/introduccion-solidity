// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VariableTypes {
    
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }

    /* BOOLEANS */
    function testBooleans(
        string memory operation,
        bool boolean1,
        bool boolean2
    ) public pure returns (bool) {
        if (compareStrings(operation, "negacion")) {
            // Handle negación as needed
            return !boolean1;
        } else if (compareStrings(operation, "conjuncion")) {
            // Handle conjunción logic
            return boolean1 && boolean2;
        } else if (compareStrings(operation, "disyuncion")) {
            // Handle disyunción logic
            return boolean1 || boolean2;
        } else {
            // Directly compare boolean values
            return boolean1 == boolean2;
        }
    }

    /* INTEGERS */
    function testIntegers(
        string memory operation,
        uint256 integer1,
        uint256 integer2
    ) public pure returns (bool) {
        if (compareStrings(operation, "menorIgual")) {
            // <=
            return integer1 <= integer2;
        } else if (compareStrings(operation, "menor")) {
            // <
            return integer1 < integer2;
        } else if (compareStrings(operation, "igual")) {
            // ==
            return integer1 == integer2;
        } else if (compareStrings(operation, "distinto")) {
            // !=
            return integer1 != integer2;
        } else if (compareStrings(operation, "mayorIgual")) {
            // >=
            return integer1 >= integer2;
        } else {
            // >
            return integer1 > integer2;
        }
    }
}
