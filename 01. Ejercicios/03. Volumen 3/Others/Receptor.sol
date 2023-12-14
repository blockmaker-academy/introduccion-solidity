// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./OperacionesMatematicas.sol";

contract Receptor {
    address public propietario;
    mapping(address => bool) public administradores;
    event FondosRecibidos(address indexed remitente, uint256 monto);

    constructor() {
        propietario = msg.sender;
        administradores[msg.sender] = true;
    }

    modifier soloPropietario() {
        require(msg.sender == propietario, "No es el propietario");
        _;
    }

    modifier soloAdmin() {
        require(administradores[msg.sender], "No es un administrador");
        _;
    }

    function agregarAdmin(address nuevoAdmin) external soloPropietario {
        administradores[nuevoAdmin] = true;
    }

    function retirar() external soloPropietario {
        payable(propietario).transfer(address(this).balance);
    }

    function sumarDiez(uint256 valor) external pure returns (uint256 resultado) {
        // Utiliza la librería para realizar una operación matemática
        resultado = OperacionesMatematicas.suma(valor, 10);
        // Realiza una verificación adicional después de la operación
        assert(resultado % 2 == 0);
        return resultado;
    }

    receive() external payable {
        emit FondosRecibidos(msg.sender, msg.value);
    }
}