// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ContratoBase.sol";

contract ContratoDerivado is ContratoBase {
    // Sobrescribe la función multiplicar
    function multiplicar(uint256 x) external view override returns (uint256) {
        // Agrega lógica adicional en el contrato derivado
        return valor * x * 2;
    }
}