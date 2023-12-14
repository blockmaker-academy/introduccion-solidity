// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContratoDestino {
    uint256 public valor;

    function setValor(uint256 _valor) external {
        valor = _valor;
    }
}

contract ContratoOrigen {
    // address public direccionDestino = 0x1234567890123456789012345678901234567890;

    function llamarSetValor(uint256 nuevoValor, address direccionDestino) external {
        // Aquí estamos llamando a la función setValor del ContratoDestino mediante la función call
        (bool exito, ) = direccionDestino.call{value: 0}(abi.encodeWithSignature("setValor(uint256)", nuevoValor));
        // <address>.call{value: xxx}(abi.encodeWithSignature(<firma_funcion>, <paramentros>) returns(bool, bytes memory)
        // Verificar si la llamada fue exitosa
        // 
        require(exito, "La llamada a setValor no fue exitosa");
    }
}