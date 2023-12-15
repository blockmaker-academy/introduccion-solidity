// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Llamador {
    event LlamadaExitosa(
        address llamante,
        address receptor,
        uint256 cantidad
    );

    function llamarYPagar(address payable receptor) external payable {
        require(msg.value > 0, "ERROR: La cantidad tiene que ser superior a 0");
        // (exito, datos) = <address>.call{value: <cantidad>}(abi.encodeWithSignature(<firma_funcion>, <parametros>));
        (bool exito, ) = receptor.call{value: msg.value}("");
        // Llamar funcion
        // (bool exito, bytes memory datos) = receptor.call("obtenerSaldo(address)", msg.sender);
        // comprobación
        require(exito, "ERROR: La funcion call para enviar ether ha fallado");
        // emitir evento
        emit LlamadaExitosa(msg.sender, receptor, msg.value);
    }
}