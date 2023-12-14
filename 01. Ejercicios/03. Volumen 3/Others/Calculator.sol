// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLibrary {
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) external pure returns (uint256) {
        require(b <= a, "La resta resultaria en un numero negativo");
        return a - b;
    }
}

// Contrato que utiliza la biblioteca
contract Calculator {
    
    // Función que utiliza la biblioteca para sumar dos números
    function addNumbers(uint256 x, uint256 y) public pure returns (uint256) {
        // Utilizar la función de la biblioteca
        return MathLibrary.add(x, y);
    }

    // Función que utiliza la biblioteca para restar dos números
    function subtractNumbers(uint256 x, uint256 y) public pure returns (uint256) {
        // Utilizar la función de la biblioteca
        return MathLibrary.subtract(x, y);
    }
}