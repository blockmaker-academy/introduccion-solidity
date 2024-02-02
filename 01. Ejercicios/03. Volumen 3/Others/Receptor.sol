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
        uint256[] prestamosids;
    }

    mapping(address => Cliente) public clientes;
    mapping(address => bool) public empleadosPrestamista;

    event SolicitudPrestamo(address prestatario, uint256 monto, uint256 plazo);
    event PrestamoAprobado(address prestatario, uint256 monto);
    event PrestamoReembolsado(address prestatario, uint256 monto);
    event GarantiaLiquidada(address prestatario, uint256 monto);

    modifier soloSocioPrincipal(address _socioPrincipal) {
        require(_socioPrincipal==msg.sender, "No eres el socio Principal");
        _;
    }

    modifier soloEmpleadoPrestamista() {
        require(empleadosPrestamista[msg.sender], "No estas dado de alta como prestamista");
        _;
    }

    modifier soloClienteRegistrado() {
        require(clientes[msg.sender].activado, "No estas dado de alta como cliente");
        _;
    }

    constructor() {
        socioPrincipal = msg.sender;
        empleadosPrestamista[socioPrincipal] = true;
    }

    function altaPrestamista(address _nuevoPrestamista) public soloSocioPrincipal(socioPrincipal) {
        require(!empleadosPrestamista[_nuevoPrestamista], "Ya estas dado de alta");
        empleadosPrestamista[_nuevoPrestamista] = true;
    }

    function altaCliente(address _nuevoCliente) public soloEmpleadoPrestamista {
        require(!clientes[_nuevoCliente].activado, "Error: Ya estabas dado de alta");
        Cliente storage structNuevoCliente = clientes[_nuevoCliente];
        //Cliente storage structNuevoCliente = Cliente(activado,saldoGarantia,prestamos,prestamosids);

        structNuevoCliente.saldoGarantia = 0;
        structNuevoCliente.activado = true;
    }

    function depositarGarantia() public payable soloClienteRegistrado {
        clientes[msg.sender].saldoGarantia += msg.value;
    }

    function solicitarPrestamos(uint256 monto_, uint256 plazo_) public soloClienteRegistrado returns(uint256) {
        require(clientes[msg.sender].saldoGarantia >= monto_, "Error: No tienes suficiente saldoGarantia");
        uint256 nuevoId = clientes[msg.sender].prestamosids.length + 1;
        Prestamo storage nuevoPrestamo = clientes[msg.sender].prestamos[nuevoId];
        nuevoPrestamo.id = nuevoId;
        nuevoPrestamo.prestatario = msg.sender;
        // Calcular el monto del préstamo con el interés del 10%
        uint256 montoConInteres = monto_ * 110 / 100;
        nuevoPrestamo.monto = montoConInteres;
        
       
        nuevoPrestamo.plazo = plazo_;
        nuevoPrestamo.tiempoSolicitud = block.timestamp; // la fecha actual
        nuevoPrestamo.tiempoLimite = 0; // cambiará al ser aprobado
        nuevoPrestamo.aprobado = false;
        nuevoPrestamo.reembolsado = false;
        nuevoPrestamo.liquidado = false;
        clientes[msg.sender].prestamosids.push(nuevoId);
        emit SolicitudPrestamo(msg.sender, monto_, plazo_);

        return (nuevoId);
    }

    function aprobarPrestamo(address prestatario_, uint256 id_) public soloEmpleadoPrestamista {
        Cliente storage prestatario = clientes[prestatario_];
        require(id_ > 0 && prestatario.prestamosids.length >= id_,"Error:Prestamo ya asignado");
        Prestamo storage prestamo = prestatario.prestamos[id_];
        require(!prestamo.aprobado,"Prestamo no aprobado");
        require(!prestamo.reembolsado,"Prestamo ya reembolsado");
        require(!prestamo.liquidado,"Prestamo ya liquidado");
        prestamo.aprobado = true;
        prestamo.tiempoLimite = block.timestamp + prestamo.plazo;
        emit PrestamoAprobado(prestatario_, prestamo.monto);

    }

    function reembolsarPrestamo(uint256 id_) public payable soloClienteRegistrado {
        Cliente storage prestatario = clientes[msg.sender];
        require(id_ > 0 && prestatario.prestamosids.length >= id_,"Error:Prestamo ya reembolsado");
        Prestamo storage prestamo = prestatario.prestamos[id_];
        require(prestamo.prestatario == msg.sender,"Credenciales invalidas");
        require(prestamo.aprobado, "Prestamo no autorizado");
        require(!prestamo.reembolsado, "Prestamo ya reembolsado");
        require(!prestamo.liquidado, "Prestamo ya liquidado");
        require(prestamo.tiempoLimite >= block.timestamp, "Tiempo limite vencido");
        // Prestatario tiene que enviar al menos el monto con interés
        uint256 montoConInteres = prestamo.monto * 110 / 100;
        require(msg.value >= montoConInteres, "No es suficiente");

        //payable(socioPrincipal).transfer(msg.value);
        payable(socioPrincipal).transfer(montoConInteres);
        prestamo.reembolsado = true;
        prestatario.saldoGarantia -= prestamo.monto;
        emit PrestamoReembolsado(prestamo.prestatario, prestamo.monto);

    }

        function liquidarGarantia(address prestatario_, uint256 id_) public soloEmpleadoPrestamista {
            Cliente storage prestatario = clientes[prestatario_];
            require(id_ > 0 && prestatario.prestamosids.length >= id_,"Error:Prestamo inexistente para este prestatario");
            Prestamo storage prestamo = prestatario.prestamos[id_];       
            require(prestamo.aprobado, "Prestamo no autorizado");
            require(!prestamo.reembolsado, "Prestamo ya reembolsado");
            require(!prestamo.liquidado, "Prestamo ya liquidado");
            require(prestamo.tiempoLimite < block.timestamp, "Tiempo limite NO vencido");
            payable(socioPrincipal).transfer(prestamo.monto);
            prestamo.liquidado = true;
            prestatario.saldoGarantia -= prestamo.monto;
            emit GarantiaLiquidada(prestamo.prestatario, prestamo.monto);
        }

        function obtenerPrestamosPorPrestatario(address prestatario_) public view returns(uint256[] memory) {
            return(clientes[prestatario_].prestamosids);
        }

        function obtenerDetalleDePrestamo(address prestatario_, uint256 id_) public view returns(Prestamo memory) {
            return(clientes[prestatario_].prestamos[id_]);
        }
    }


