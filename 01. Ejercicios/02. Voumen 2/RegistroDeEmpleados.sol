// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RegistroDeEmpleados {

    address public propietario;

    constructor() {
        propietario = msg.sender;
    }

    struct Empleado {
        uint256 idEmpleado;
        string nombre;
        uint256 salario;
    }

    mapping(uint256 => Empleado) public empleados;

    function agregarEmpleado(
        uint256 _idEmpleado,
        string memory _nombre,
        uint256 _salario
    ) public {
       require(msg.sender == propietario, "No eres el propietario");
       require(empleados[_idEmpleado].idEmpleado == 0, "El empleado ya esta dado de alta");
       empleados[_idEmpleado] = Empleado(_idEmpleado, _nombre, _salario);
    }

    function obtenerEmpleado(uint256 _idEmpleado) public view returns (uint256, string memory, uint256) {
        Empleado memory empleado = empleados[_idEmpleado];
        require(empleado.idEmpleado != 0, "El empleado no existe");
        return (empleado.idEmpleado, empleado.nombre, empleado.salario);
    }


}