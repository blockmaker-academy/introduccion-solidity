// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContratoBase {
    uint256 public valor;

    function multiplicar(uint256 x) external view virtual returns (uint256) {
        return valor * x;
    }
}

