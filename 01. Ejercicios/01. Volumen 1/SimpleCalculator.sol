pragma solidity ^0.8.0;

contract SimpleCalculator {
    // Function to add two integers and return the result
    function add(int a, int b) public pure returns (int) {
        int result = a + b;
        return result;
    }

    // Function to subtract one integer from another and return the result
    function subtract(int a, int b) public pure returns (int) {
        int result = a - b;
        return result;
    }

    // Function to multiply two integers and return the result
    function multiply(int a, int b) public pure returns (int) {
        int result = a * b;
        return result;
    }
}


