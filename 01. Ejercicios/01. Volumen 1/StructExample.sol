// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructExample {
    // Define a struct called 'Person'
    struct Person {
        string name;
        uint256 age;
    }

    // Create an instance of the 'Person' struct
    Person public alice = Person("Alice", 30);

    // Function to get the name and age of 'alice'
    function getPersonDetails() public view returns (string memory, uint256) {
        return (alice.name, alice.age);
    }
}
