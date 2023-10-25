// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Counter.sol";

contract CounterManager {
    Counter public counterContract;

    function incrementCounter() public {
        counterContract.increment();
    }

    function getCounterValue() public view returns (uint) {
        return counterContract.getCount();
    }
}

