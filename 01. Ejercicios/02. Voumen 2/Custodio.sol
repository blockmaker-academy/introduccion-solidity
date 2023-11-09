// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Custodio {

    // address => msg.sender
    // address payable => payable(msg.sender)
    // uint256 prueba; 50
    // uint pruebaMejorada = uint8(prueba);

    // function payable => función que permite transferir fondos a un contrato
    function enviarFondos() public payable {
        require(msg.value > 0, "No estan enviando fondos");
    }

    // address payable => tipología que permite enviar fondos a una dirección
    function retirarFondos(uint256 _cantidad) public {
        payable(msg.sender).transfer(_cantidad);
        // address payable => send / transfer
    }

}