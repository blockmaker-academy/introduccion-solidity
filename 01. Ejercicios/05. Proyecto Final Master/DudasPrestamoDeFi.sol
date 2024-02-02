// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DudasPrestamoDeFi {

    function depositarGarantia() external payable {
        // ...
        clientes[msg.sender].saldoGaratia += msg.value;
    }

    function transferGarantia() external {
        payable(socioPrincipal).transfer(prestamo.monto);
        // acceder mapping empleadosPrestamita
        empleadosPrestamita[msg.sender] == true;
    }

    modifier soloSocioPrincipal() {
        require(msg.sender == socioPrincipalAddress, "Solo el socio principal puede realizar esta operacion");
    }

    function obtenerDetallePrestamo(address prestatario, uint256 idPrestamo) external view returns (Prestamo memory) {
        return ....;
    }
}