// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroDeEmpleados {
    address public propietario;
    
    struct Empleado {
        uint256 idEmpleado;
        string nombre;
        uint256 salario;
    }

    mapping(uint256 => Empleado) public empleados;

    constructor() {
        propietario = msg.sender;
    }

    function agregarEmpleado(
        uint256 _idEmpleado,
        string memory _nombre,
        uint256 _salario
    ) public {
        require(msg.sender == propietario, "Solo el propietario puede agregar empleados");
        require(empleados[_idEmpleado].idEmpleado == 0, "Empleado con esta identificacion ya existe");
        empleados[_idEmpleado] = Empleado(_idEmpleado, _nombre, _salario);
    }

    function obtenerEmpleado(uint256 _idEmpleado) public view returns (uint256, string memory, uint256) {
        Empleado memory empleado = empleados[_idEmpleado];
        require(empleado.idEmpleado != 0, "Empleado con esta identificacion no existe");
        return (empleado.idEmpleado, empleado.nombre, empleado.salario);
    }

    function actualizarSalarioEmpleado(
        uint256 _idEmpleado,
        uint256 _salario
    ) public {
        require(msg.sender == propietario, "Solo el propietario puede actualizar salarios de empleados");
        require(empleados[_idEmpleado].idEmpleado != 0, "Empleado con esta identificacion no existe");
        empleados[_idEmpleado].salario = _salario;
    }

    function eliminarEmpleado(uint256 _idEmpleado) public {
        require(msg.sender == propietario, "Solo el propietario puede eliminar empleados");
        require(empleados[_idEmpleado].idEmpleado != 0, "Empleado con esta identificacion no existe");
        delete empleados[_idEmpleado];
    }
}