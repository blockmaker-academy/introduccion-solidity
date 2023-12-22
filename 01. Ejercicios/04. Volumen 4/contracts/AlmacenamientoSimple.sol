// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AlmacenamientoSimple {
    uint256 private datos;

    function establecerDatos(uint256 _datos) public {
        datos = _datos;
    }

    function obtenerDatos() public view returns (uint256) {
        return datos;
    }
}
