// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicTryCatchExample {
    function divide(uint256 a, uint256 b) public view returns (string memory, uint256) {
        uint256 result;
        string memory message;

        try this.safeDivide(a, b) returns (uint256 _result) {
            result = _result;
            message = "Division successful";
        } catch Error(string memory errorMessage) {
            result = 0;
            message = errorMessage;
        } catch (bytes memory) {
            result = 0;
            message = "An error occurred";
        }

        return (message, result);
    }

    function safeDivide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b != 0, "Division by zero");
        return a / b;
    }
}


