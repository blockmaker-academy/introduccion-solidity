// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Custodio {

    // msg.sender: Es la dirección de la cuenta que envió la transacción actual al contrato inteligente. Identifica al remitente de la transacción.
    // msg.value: Representa la cantidad de Ether (en wei) enviada junto con la transacción. Puede utilizarse para enviar fondos al contrato inteligente.
    
    // <address>.balance (uint256) Este miembro devuelve el saldo en Wei (la unidad más pequeña de Ether) de la dirección Ethereum. Es una propiedad de sólo lectura.
    // <address payable>.transfer(uint256 amount) Esta función permite enviar Ether desde el contrato a otra dirección Ethereum. Tiene incorporado el manejo de errores y revertirá la transacción si la transferencia falla.

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