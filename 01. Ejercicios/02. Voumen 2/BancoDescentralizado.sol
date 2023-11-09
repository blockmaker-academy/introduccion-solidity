// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BancoDescentralizado {
    address private propietario;

    mapping(address => uint256) private saldos;

    constructor() {
        propietario = msg.sender;
    }

    function depositar() public payable {
        require(msg.value > 0, "Debes enviar Ether para depositar.");
        saldos[msg.sender] += msg.value;
    }

    function retirar(uint256 _cantidad) public {
        require(msg.sender != propietario, "El propietario del banco no puede retirar los fondos.");
        require(saldos[msg.sender] >= _cantidad, "Saldo insuficiente.");
        saldos[msg.sender] -= _cantidad;
        payable(msg.sender).transfer(_cantidad);
    }

    function obtenerSaldo() public view returns (uint256) {
        return saldos[msg.sender];
    }