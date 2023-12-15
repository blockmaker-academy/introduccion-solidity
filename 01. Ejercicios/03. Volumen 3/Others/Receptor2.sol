// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {OperacionesMatematicas2} from "./OperacionesMatematicas2.sol";

contract Receptor2 {
    address public propietario;
    mapping(address => bool) administradores; // 0x642 => true;
    event FondosRecibidos(address remitente, uint256 valor);

    constructor() {
        propietario = msg.sender;
        administradores[msg.sender] = true;
    }

    modifier soloPropietario() {
        require(msg.sender == propietario, "ERROR: no eres el propietario");
        _;
    }

    modifier soloAdmin() {
        require(administradores[msg.sender], "ERROR: no eres administrador");
        _;
    }

    function agregarAdmin(address nuevoAdministrador) external soloPropietario {
        administradores[nuevoAdministrador] = true;
    }

    function retirar() external soloPropietario {
        payable(propietario).transfer(address(this).balance);
    }

    function sumarDiez(uint256 valor) external pure returns(uint256) {
        try OperacionesMatematicas2.suma(valor, 10) returns(uint256 resultado_) {
            return resultado_;
        } catch Error(string memory error) {
            revert(error);
        } catch Panic(uint256) {
            revert("Error de panico");
        } catch (bytes memory) {
            revert("Excepcion de bajo nivel");
        }
    }

    // receive function para recibir ether
    receive() external payable {
        emit FondosRecibidos(msg.sender, msg.value);
    }

}