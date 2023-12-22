// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BancoDescentralizado {
    address public propietario;
    mapping(address => uint256) public saldos;

    constructor() {
        propietario = msg.sender;
    }

    function depositar() public payable {
        require(msg.value > 0, "Debes enviar algo de Ether para poder depositar saldo");
        saldos[msg.sender] += msg.value;
    }

    function retirar(uint256 _cantidad) public {
        require(msg.sender != propietario, "No puedes retirar fondos de tus clientes");
        require(saldos[msg.sender] >= _cantidad, "Saldo insuficiente");
        saldos[msg.sender] -= _cantidad;
        payable(msg.sender).transfer(_cantidad);
    }

    function transferir(address _emisor, uint256 _cantidad) public {
        require(msg.sender != propietario, "No puedes transferir fondos de tus clientes");
        require(saldos[msg.sender] >= _cantidad, "Saldo insuficiente");
        saldos[msg.sender] -= _cantidad;
        saldos[_emisor] += _cantidad;
    }
}