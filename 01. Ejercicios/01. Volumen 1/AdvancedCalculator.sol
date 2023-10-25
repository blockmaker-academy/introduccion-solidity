pragma solidity ^0.8.0;

contract AdvancedCalculator {
    // Function to perform integer division and return the result
    function divide(int a, int b) public pure returns (int) {
        require(b != 0, "Division by zero is not allowed.");
        int result = a / b;
        return result;
    }

    // Function to calculate the remainder (modulo) of integer division and return the result
    function modulo(int a, int b) public pure returns (int) {
        require(b != 0, "Modulo by zero is not allowed.");
        int result = a % b;
        return result;
    }

    // Function to calculate the exponentiation of an integer and return the result
    function power(int base, uint exponent) public pure returns (int) {
        // Ensure the result is cast back to int
        return int(uint(base) ** exponent);
    }
}
