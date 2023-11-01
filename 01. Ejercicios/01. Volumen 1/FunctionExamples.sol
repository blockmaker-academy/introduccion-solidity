// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionExamples {
    uint256 stateVariable;

    constructor() {
        stateVariable = 0;
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
    function sumar(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // EJERCICIO
    // function <NOMBRE_DE_LA_FUNCIÓN> (<PARAMETROS_ENTRADA) <VISIBILIDAD> <MUTABILIDAD> <RETURNS_O_NO>
    // Una función
    // entrada: uint256, string, bool
    // salida: uint256, string, bool
    // visibilidad: public, internal, external
    // mutabilidad del estado: pure, view

    function devolverVariables(
        uint256 numero,
        string memory cadena,
        bool booleano
    ) public pure returns (uint256, string memory, bool) {
        return (numero, cadena, booleano);
    }
}