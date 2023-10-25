// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionExamples {
    uint256 public stateVariable;

    constructor() {
        stateVariable = 0;
    }

    // Payable function that modifies state and accepts Ether
    function setStateVariable(uint256 _newValue) public payable {
        require(msg.value >= 1 ether, "Must send at least 1 Ether");
        stateVariable = _newValue;
    }

    // Nonpayable function that modifies state but does not accept Ether
    function incrementStateVariable(uint256 _value) public {
        stateVariable += _value;
    }

    // View function that reads state but does not modify it
    function getStateVariable() public view returns (uint256) {
        return stateVariable;
    }

    // Pure function that performs a calculation and does not access state
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }
}
