// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjemploRevert {

    function lanzarRevert() public pure {
        revert("Funcion revertida");
    }

    function lanzarRequire(bool _prueba) public pure {
        require(_prueba, "Funcion require");
    }

}