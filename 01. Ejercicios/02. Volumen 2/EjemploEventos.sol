// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjemploEventos {
    address public propietario;
    uint256 public contador;

    // Definición de un evento
    event ContadorIncrementado(address indexed remitente, uint256 nuevoValorContador);

    constructor() {
        propietario = msg.sender;
        contador = 0;
    }

    // Función que incrementa el contador y emite un evento
    function incrementarContador() public {
        require(msg.sender == propietario, "Solo el propietario puede incrementar el contador");
        contador++;
        // Emitiendo el evento
        emit ContadorIncrementado(msg.sender, contador);
    }

    // Función para obtener el valor actual del contador
    function obtenerContador() public view returns (uint256) {
        return contador;
    }
}
