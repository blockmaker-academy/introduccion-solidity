// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library OperacionesMatematicas2 {
    function suma(uint256 a, uint256 b) external pure returns(uint256) {
        return a + b;
    }

    function restar(uint256 a, uint256 b) external pure returns(uint256) {
        require(a >= b, "ERROR: La resta no puede ser negativa");
        return a - b;
    }

    function dividir(uint256 a, uint256 b) external pure returns(uint256) {
        require(b != 0, "ERROR: La resta no puede ser negativa");
        return a - b;
    }
} 