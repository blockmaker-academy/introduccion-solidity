// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControlExample {
    address public owner;
    bool public isPaused;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    modifier whenNotPaused() {
        require(!isPaused, "Contract is paused");
        _;
    }

    constructor() {
        owner = msg.sender;
        isPaused = false;
    }

    function pauseContract() public onlyOwner {
        isPaused = true;
    }

    function resumeContract() public onlyOwner {
        isPaused = false;
    }

    function withdrawFunds(uint256 amount) public onlyOwner whenNotPaused {
        // Function code for withdrawing funds
        // This function can only be executed by the owner when the contract is not paused
    }
}