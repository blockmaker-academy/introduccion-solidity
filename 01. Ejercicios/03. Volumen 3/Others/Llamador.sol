// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Llamador {
    event LlamadaExitosa(address llamante, address receptor, uint256 monto);

    function llamarYPagar(address payable receptor) external payable {
        require(msg.value > 0, "El valor debe ser mayor que 0");
        
        // Realiza la llamada y transfiere los fondos
        (bool success, ) = receptor.call{value: msg.value}("");
        require(success, "Llamada fallida");
        
        emit LlamadaExitosa(msg.sender, receptor, msg.value);
    }
}