// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Counter } from "./Counter.sol";

contract CounterManager is Counter {

    constructor() Counter() {
        // no introducimos nada en este constructor ya que sólo queremos
        // inicializar el contrato Counter
    }

    function incrementCounter() public {
        Counter.increment();
    }

    function getCounterValue() public view returns (uint) {
        return Counter.getCount();
    }
}

