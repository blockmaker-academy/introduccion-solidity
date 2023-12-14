// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract EjemploExcepciones {

    function operacionAritmetica(uint256 a, uint256 b) external pure returns (uint256) {
        // Alguna operación que podría lanzar una excepción
        if (b == 0) {
            revert("No se puede dividir por cero");
        }
        return a / b;
    }

    function dividir(uint256 a, uint256 b) external view returns (uint256) {
        // Usando try-catch para manejar una posible excepción de división por cero
        try this.operacionAritmetica(a, b) returns (uint256 resultado) {
            // El código en este bloque se ejecuta si la división es exitosa
            return resultado;
        } catch Error(string memory mensajeError) {
            // El código en este bloque se ejecuta si ocurre un error en
            // operacionAritmetica y se realizar un revert con un string
            revert(mensajeError);
        } catch Panic(uint256 codigoError) {
            // El código de este bloque se ejecuta si ocurre un error de pánico
            // es decir, un error grave como división por cero (en nuestro caso
            // está controlado) o desbordamiento. El código de error puede utilizarse
            // para determinar el tipo de error.
            
            // Uso de la librería 'Strings' de OpenZeppelin para conversion
            // de uint256 a string
            revert(string.concat("Codigo de error: ", Strings.toString(codigoError)));
        } catch (bytes memory /* datosBajonivel */) {
            // El código en este bloque se ejecuta si ocurre una excepción de bajo nivel
            // (por ejemplo, falta de gas)
            revert("Excepcion de bajo nivel");
        }
    }
}
