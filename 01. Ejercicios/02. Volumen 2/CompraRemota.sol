// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract CompraRemota {
    uint public valor;
    address payable public vendedor;
    address payable public comprador;

    enum Estado { Creado, Bloqueado, Liberado, Inactivo }
    // La variable de estado tiene un valor predeterminado del primer miembro, `Estado.Creado`
    Estado public estado;

    modifier condicion(bool condicion_) {
        require(condicion_);
        _;
    }

    /// Solo el comprador puede llamar a esta función.
    error SoloComprador();
    /// Solo el vendedor puede llamar a esta función.
    error SoloVendedor();
    /// La función no puede ser llamada en el estado actual.
    error EstadoInvalido();
    /// El valor proporcionado debe ser par.
    error ValorNoPar();

    modifier soloComprador() {
        if (msg.sender != comprador)
            revert SoloComprador();
        _;
    }

    modifier soloVendedor() {
        if (msg.sender != vendedor)
            revert SoloVendedor();
        _;
    }

    modifier enEstado(Estado estado_) {
        if (estado != estado_)
            revert EstadoInvalido();
        _;
    }

    event Abortado();
    event CompraConfirmada();
    event ArticuloRecibido();
    event VendedorReembolsado();

    // Asegurarse de que `msg.value` sea un número par.
    // La división se truncará si es un número impar.
    // Verificar a través de la multiplicación que no fue un número impar.
    constructor() payable {
        vendedor = payable(msg.sender);
        valor = msg.value / 2;
        if ((2 * valor) != msg.value)
            revert ValorNoPar();
    }

    /// Abortar la compra y reclamar el ether.
    /// Solo puede ser llamado por el vendedor antes de que
    /// el contrato esté bloqueado.
    function abortar()
        external
        soloVendedor
        enEstado(Estado.Creado)
    {
        emit Abortado();
        estado = Estado.Inactivo;
        // Usamos transfer aquí directamente. Es
        // seguro contra reentrancia, porque es el
        // último llamado en esta función y ya
        // cambiamos el estado.
        vendedor.transfer(address(this).balance);
    }

    /// Confirmar la compra como comprador.
    /// La transacción debe incluir `2 * valor` ether.
    /// El ether se bloqueará hasta que se llame a confirmarRecibido.
    function confirmarCompra()
        external
        enEstado(Estado.Creado)
        condicion(msg.value == (2 * valor))
        payable
    {
        emit CompraConfirmada();
        comprador = payable(msg.sender);
        estado = Estado.Bloqueado;
    }

    /// Confirmar que tú (el comprador) recibiste el artículo.
    /// Esto liberará el ether bloqueado.
    function confirmarRecibido()
        external
        soloComprador
        enEstado(Estado.Bloqueado)
    {
        emit ArticuloRecibido();
        // Es importante cambiar el estado primero porque
        // de lo contrario, los contratos llamados usando `send` a continuación
        // pueden llamar nuevamente aquí.
        estado = Estado.Liberado;

        comprador.transfer(valor);
    }

    /// Esta función reembolsa al vendedor, es decir,
    /// paga de nuevo los fondos bloqueados del vendedor.
    function reembolsarVendedor()
        external
        soloVendedor
        enEstado(Estado.Liberado)
    {
        emit VendedorReembolsado();
        // Es importante cambiar el estado primero porque
        // de lo contrario, los contratos llamados usando `send` a continuación
        // pueden llamar nuevamente aquí.
        estado = Estado.Inactivo;

        vendedor.transfer(3 * valor);
    }
}
