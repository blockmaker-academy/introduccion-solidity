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

    event EmpleadoAgregado(uint256 indexed idEmpleado, string nombre, uint256 salario);
    event EmpleadoEliminado(uint256 indexed idEmpleado);
    event SalarioModificado(uint256 indexed idEmpleado, uint256 salario);

    error ErrorNoEresPropietario();

    modifier soloPropietario() {
        require(propietario == msg.sender, "Error: no eres el propietario");
        // continue
        _;
    }

    modifier empleadoExiste(uint256 _idEmpleado) {
        require(empleados[_idEmpleado].idEmpleado != 0, "Error: el empleado no existe");
        _;
    }

    constructor() {
        // msg.sender / msg.value / block.timestamp != pure
        propietario = msg.sender;
    }

    function agregarEmpleado(
        uint256 _idEmpleado,
        string memory _nombre,
        uint256 _salario
    ) public soloPropietario {
        require(empleados[_idEmpleado].idEmpleado == 0, "Error: el empleado ya existe");
        empleados[_idEmpleado] = Empleado(
            _idEmpleado,
            _nombre,
            _salario
        );

        // emitir evento EmpleadoAgregado(idEmpleado, nombre, salario)
        emit EmpleadoAgregado(_idEmpleado, _nombre, _salario);
    }

    function obtenerEmpleado(uint256 _idEmpleado) public view empleadoExiste(_idEmpleado) returns(
        uint256,
        string memory,
        uint256
    ) {
        return(
            empleados[_idEmpleado].idEmpleado,
            empleados[_idEmpleado].nombre,
            empleados[_idEmpleado].salario
        );
    }

    function actualizarSalarioEmpleado(
        uint256 _idEmpleado,
        uint256 _salario
    ) public soloPropietario empleadoExiste(_idEmpleado) {
        empleados[_idEmpleado].salario = _salario; // Mapping => Struct => Campos
    }

    function eliminarEmpleado(uint256 _idEmpleado) public soloPropietario empleadoExiste(_idEmpleado) {
        delete empleados[_idEmpleado];
    }

}