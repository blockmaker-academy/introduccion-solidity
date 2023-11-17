// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mercado {
    address public propietario;

    struct Producto {
        uint256 id;
        string nombre;
        uint256 precio;
        uint256 cantidad;
        address vendedor;
    }

    mapping(uint256 => Producto) private productos;
    uint256 public contadorProductos;

    event ProductoAgregado(uint256 idProducto, string nombre, uint256 precio, uint256 cantidad, address vendedor);
    event ProductoComprado(uint256 idProducto, string nombre, uint256 precio, uint256 cantidad, address comprador);

    modifier soloPropietario() {
        require(msg.sender == propietario, "Solo el propietario puede llamar a esta funcion");
        _;
    }

    modifier productoExistente(uint256 idProducto) {
        require(idProducto <= contadorProductos && idProducto > 0, "El producto no existe");
        _;
    }

    constructor() {
        propietario = msg.sender;
        contadorProductos = 0;
    }

    function agregarProducto(
        string memory _nombre,
        uint256 _precio,
        uint256 _cantidad
        ) public soloPropietario {
            contadorProductos++;
            productos[contadorProductos] = Producto(contadorProductos, _nombre, _precio, _cantidad, msg.sender);
            emit ProductoAgregado(contadorProductos, _nombre, _precio, _cantidad, msg.sender);
    }

}