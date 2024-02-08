/ SPDX-License-Identifier: MIT
pragma
solidity
^0.8.0;


contract
 PrestamoDeFi {


   
address
public socioPrincipal;


   
struct Prestamo
{
       
uint256 idPrestamo;
       
address prestatario;
       
uint256 monto;
       
uint256 plazo;
       
uint256 tiempoSolicitud;
       
uint256 tiempoLimite;
       
bool aprobado;
       
bool reembolsado;
       
bool liquidado;
   
}


   
struct Cliente
{
       
bool activado;
       
uint256 saldoGarantia;
   
}


   
mapping(uint256
 => Prestamo)
public prestamos;


    Prestamo[]
public prestamolds;
//??


   
mapping(address
 => Cliente)
public clientes;


   
mapping(address
 => bool)
public empleadosPrestamista;
//??


   
event SolicitudPrestamo(address
 prestatario,
uint256 monto,
uint256 plazo);


   
event PrestamoAprobado(address
 prestatario,
uint256 monto);


   
event PrestamoReembolsado(address
 prestatario,
uint256 monto);


   
event GarantiaLiquidada(address
 prestatario,
uint256 monto);


   
modifier soloSocioPrincipal()
{
       
require
(msg.sender
== socioPrincipal,
"No eres el jefe");
        _;
   
}


   
modifier soloEmpleadoPrestamista()
{
       
require
(msg.sender
== empleadosPrestamista,
"No eres el jefe");
        _;
   
}


   
modifier soloClienteRegistrado()
{
       
require(clientes[msg.sender]
==
true,
"No eres cliente");
        _;
   
}


   
constructor()
{
        socioPrincipal
=
msg.sender;
       
// ??
   
}


   
function altaPrestamista(address
 nuevoPrestamista)
public soloSocioPrincipal
{
       
require//??, "El prestamista ya esta
 dado de alta");
   
}


   
function altaCliente(address
 nuevoCliente)
public soloEmpleadoPrestamista
{
       
require(//??,
 "El cliente ya esta dado de alta");
   
}


   
function depositarGarantia()
public
payable soloClienteRegistrado
{
        clientes[msg.sender].saldoGarantia
+=
msg.value;
   
}


   
function solicitarPrestamos(
       
uint256 monto_,
       
uint256 plazo_
   
)
public soloClienteRegistrado
returns
(uint256)
{


   
}


   
function aprobarPrestamo(
       
address prestatario_,
       
uint256 id_
   
)
public soloEmpleadoPrestamista
{


   
}


   
function reembolsarPrestamo(uin256
 id_)
public soloClienteRegistrado
{




       
payable(socioPrincipal).transfer(prestamo.monto);
   
}


   
function liquidarGarantia(
       
address prestatario_,
       
uint256 id_
   
)
public soloEmpleadoPrestamista
{


   
}


   
function obtenerPrestamosPorPrestatario(address
 prestatario_)
public
returns
()
{


   
}


   
function obtenerDetalleDePrestamo(
       
address prestatario_,
       
uint256 id_
   
)
public
returns
(Prestamo
memory)
{
       
   
}