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

    mapping(uint256 => Producto) public productos;
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

    function agregarProducto(string memory nombre, uint256 precio, uint256 cantidad) public soloPropietario {
        contadorProductos++;
        productos[contadorProductos] = Producto(contadorProductos, nombre, precio, cantidad, msg.sender);
        emit ProductoAgregado(contadorProductos, nombre, precio, cantidad, msg.sender);
    }

    function comprarProducto(uint256 idProducto) public payable productoExistente(idProducto) {
        Producto storage producto = productos[idProducto];
        require(producto.cantidad > 0, "Producto sin stock");
        require(msg.value >= producto.precio, "Fondos insuficientes");

        producto.cantidad--;
        payable(producto.vendedor).transfer(producto.precio);
        emit ProductoComprado(idProducto, producto.nombre, producto.precio, 1, msg.sender);
    }

    function obtenerProducto(uint256 idProducto) public view productoExistente(idProducto) returns (string memory, uint256, uint256, address) {
        Producto storage producto = productos[idProducto];
        return (producto.nombre, producto.precio, producto.cantidad, producto.vendedor);
    }

    receive() external payable {
        // Función de respaldo para aceptar Ether
    }
}