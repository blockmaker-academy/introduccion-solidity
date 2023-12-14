// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PruebaSelfDestruct {
    address payable public propietario;

    constructor() {
        propietario = payable(msg.sender);
    }

    function destruirContrato() external {
        require(msg.sender == propietario, "Error: no eres el propietario");
        
        // Destruir el contrato y enviar los fondos al propietario
        selfdestruct(propietario);
    }
}

