// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrestamoDeFi {
    address public socioPrincipal;

    struct Prestamo {
        uint256 id;
        address prestatario;
        uint256 monto;
        uint256 plazo;
        uint256 tiempoSolicitud;
        uint256 tiempoLimite;
        bool aprobado;
        bool reembolsado;
        bool liquidado;
    }

    struct Cliente {
        bool activado;
        uint256 saldoGarantia;
        mapping(uint256 => Prestamo) prestamos;
        uint256[] prestamoIds;
    }

    mapping(address => Cliente) public clientes;
    mapping(address => bool) public empleadosPrestamista;

    event SolicitudPrestamo(address indexed prestatario, uint256 monto, uint256 plazo);
    event PrestamoAprobado(address indexed prestatario, uint256 monto);
    event PrestamoReembolsado(address indexed prestatario, uint256 monto);
    event GarantiaLiquidada(address indexed prestatario, uint256 monto);

    modifier soloSocioPrincipal() {
        require(msg.sender == socioPrincipal, "No estas autorizado para realizar esta operacion");
        _;
    }

    modifier soloEmpleadoPrestamista() {
        require(empleadosPrestamista[msg.sender], "No tienes el rol de prestamista");
        _;
    }

    modifier soloClienteRegistrado() {
        require(clientes[msg.sender].activado, "No estas registrado como cliente");
        _;
    }

    constructor() {
        socioPrincipal = msg.sender;
        empleadosPrestamista[socioPrincipal] = true;
    }

    function altaPrestamista(
        address nuevoPrestamista
    ) public soloSocioPrincipal {
        require(!empleadosPrestamista[nuevoPrestamista], "El prestamista ya esta dado de alta");
        empleadosPrestamista[nuevoPrestamista] = true;
    }

    function altaCliente(
        address nuevoCliente
    ) public soloEmpleadoPrestamista {
        require(!clientes[nuevoCliente].activado, "El cliente ya esta registrado");

        Cliente storage structNuevoCliente = clientes[nuevoCliente];
        structNuevoCliente.saldoGarantia = 0;
        structNuevoCliente.activado = true;
    }

    function depositarGarantia() public payable soloClienteRegistrado {
        clientes[msg.sender].saldoGarantia += msg.value;
    }

    function solicitarPrestamo(
        uint256 monto_,
        uint256 plazo_
    ) public soloClienteRegistrado returns(uint256) {
        require(clientes[msg.sender].saldoGarantia >= monto_, "Saldo de garantia insuficiente");
        
        uint256 nuevoId = clientes[msg.sender].prestamoIds.length + 1;

        Prestamo storage nuevoPrestamo = clientes[msg.sender].prestamos[nuevoId];
        nuevoPrestamo.id = nuevoId;
        nuevoPrestamo.prestatario = msg.sender;
        nuevoPrestamo.monto = monto_;
        nuevoPrestamo.plazo = plazo_;
        nuevoPrestamo.tiempoSolicitud = block.timestamp;
        nuevoPrestamo.tiempoLimite = 0;
        nuevoPrestamo.aprobado = false;
        nuevoPrestamo.reembolsado = false;
        nuevoPrestamo.liquidado = false;

        clientes[msg.sender].prestamoIds.push(nuevoId);

        emit SolicitudPrestamo(msg.sender, monto_, plazo_);

        return nuevoId;
    }

    function aprobarPrestamo(
        address prestatario_,
        uint256 id_
    ) public soloEmpleadoPrestamista {
        Cliente storage prestatario = clientes[prestatario_];

        require(id_ > 0 && id_ <= prestatario.prestamoIds.length, "ID de prestamo no valido");
        
        Prestamo storage prestamo = prestatario.prestamos[id_];

        require(!prestamo.aprobado, "El prestamo ya esta aprobado");
        require(!prestamo.reembolsado, "El prestamo ya ha sido reembolsado");
        require(!prestamo.liquidado, "El prestamo ya ha sido liquidado");

        prestamo.aprobado = true;
        prestamo.tiempoLimite = block.timestamp + prestamo.plazo;

        emit PrestamoAprobado(prestatario_, prestamo.monto);
    }

    function reembolsarPrestamo(
        uint256 id_
    ) public soloClienteRegistrado {
        Cliente storage prestatario = clientes[msg.sender];
        require(id_ > 0 && id_ <= prestatario.prestamoIds.length, "ID de prestamo no valido");
        
        Prestamo storage prestamo = prestatario.prestamos[id_];

        require(msg.sender == prestamo.prestatario, "No estas autorizado para reembolsar este prestamo");
        require(prestamo.aprobado, "El prestamo no esta aprobado");
        require(!prestamo.reembolsado, "El prestamo ya ha sido reembolsado");
        require(!prestamo.liquidado, "El prestamo ha sido liquidado");
        require(block.timestamp <= prestamo.tiempoLimite, "Tiempo de pago expirado");

        payable(socioPrincipal).transfer(prestamo.monto);

        prestamo.reembolsado = true;

        prestatario.saldoGarantia -= prestamo.monto;

        emit PrestamoReembolsado(msg.sender, prestamo.monto);
    }

    function liquidarGarantia(
        address prestatario_,
        uint256 id_
    ) public soloEmpleadoPrestamista {
        Cliente storage prestatario = clientes[prestatario_];
        require(id_ > 0 && id_ <= prestatario.prestamoIds.length, "ID de prestamo no valido");
        
        Prestamo storage prestamo = prestatario.prestamos[id_];

        require(prestamo.aprobado, "El prestamo no esta aprobado");
        require(!prestamo.reembolsado, "El prestamo ya ha sido reembolsado");
        require(!prestamo.liquidado, "El prestamo ya ha sido liquidado");
        require(block.timestamp > prestamo.tiempoLimite, "Tiempo de pago no ha expirado");

        payable(socioPrincipal).transfer(prestamo.monto);

        prestamo.liquidado = true;
        prestatario.saldoGarantia -= prestamo.monto;

        emit GarantiaLiquidada(prestatario_, prestamo.monto);
    }

    function obtenerPrestamosPorPrestatario(
        address prestatario_
    ) public view returns(uint256[] memory) {
        return clientes[prestatario_].prestamoIds;
    }

    function obtenerDetalleDePrestamo(
        address prestatario_,
        uint256 id_
    ) public view returns(Prestamo memory) {
        return clientes[prestatario_].prestamos[id_];
    }
}