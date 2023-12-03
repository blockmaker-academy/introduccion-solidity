// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructuresExample {
    uint256 public counter = 0;

    // Function to demonstrate if-else, while, do-while, for, break, and continue
    function controlStructuresExample(uint256 num) public returns (string memory) {
        // If-else statement
        if (num > 10) {
            return "Number is greater than 10";
        } else {
            return "Number is not greater than 10";
        }

        // While loop
        while (counter < num) {
            counter++;
        }

        // Do-while loop
        do {
            counter--;
        } while (counter > 0);

        // For loop
        for (uint256 i = 0; i < num; i++) {
            if (i == 5) {
                break; // Break the loop when i is equal to 5
            }
            if (i == 2) {
                continue; // Skip the iteration when i is equal to 2
            }
            counter += i;
        }

        return "Control structures executed";
    }

    // Function to demonstrate try-catch and return
    function divideSafely(uint256 a, uint256 b) public returns (string memory) {
        try this.controlStructuresExample(a / b) returns (string memory result) {
            return result;
        } catch Error(string memory) {
            return "Error: Division by zero or other error occurred";
        }
    }
}
