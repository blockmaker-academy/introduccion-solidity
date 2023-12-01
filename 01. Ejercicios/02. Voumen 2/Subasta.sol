// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Subasta {
    address public propietario;

    address payable public beneficiario; // 0x5828...
    uint256 public finSubasta; // 1323423534231423 => 1 Nov 2023, 12:24:25

    address public mejorPostor; // 0x5235...
    uint256 public mejorOferta; // 3.5

    mapping(address => uint256) devolucionesPendientes; // devolucionesPendientes['0x356'] => 3

    bool finalizada;

    event OfertaMasAltaIncrementada(address indexed postor, uint256 cantidad);
    event SubastaFinalizada(address indexed ganador, uint256 cantidad);

    /// La subasta ya ha finalizado.
    error SubastaYaFinalizada();
    /// Ya existe una oferta igual o superior.
    error OfertaNoSuficientementeAlta(uint256 mejorOferta);
    /// La subasta aún no ha finalizado.
    error SubastaNoFinalizadaTodavia();
    /// La función auctionEnd ya ha sido llamada.
    error FinSubastaYaLlamado();

    modifier soloPropietario() {
        require(msg.sender == propietario, "No eres el propietario");
        _;
    }

    constructor(uint256 tiempoOferta, address payable addressBeneficiario)  {
        beneficiario = addressBeneficiario;
        finSubasta = block.timestamp + tiempoOferta;
    }

    // Sin require
    function ofertar() public payable {

        if(block.timestamp > finSubasta) {
            revert SubastaYaFinalizada();
        }

        if(msg.value <= mejorOferta) {
            revert OfertaNoSuficientementeAlta(mejorOferta);
        }

        if(mejorOferta != 0) {
            devolucionesPendientes[mejorPostor] += mejorOferta;
        }

        mejorPostor = msg.sender;
        mejorOferta = msg.value;

        emit OfertaMasAltaIncrementada(mejorPostor, mejorOferta);
    }

    // Con require
    function ofertar2() public payable {

    }

    // Sin require
    function retirar() public returns(bool) {
        uint256 cantidad = devolucionesPendientes[msg.sender]; // valor que le debemos al emisor
        // te debo pasta
        if (cantidad > 0) {

            // no consigo realizar el envío de fondos
            if(!payable(msg.sender).send(cantidad)) { // !false => true
                return false;
            }

            // envío de fondos realizado
            devolucionesPendientes[msg.sender] = 0;
            return true;
        }
        return false;
    }

    // Con require
    function retirar2() public {
        require(devolucionesPendientes[msg.sender] > 0, "No hay deudas pendientes para ti");
        require(!payable(msg.sender).send(devolucionesPendientes[msg.sender]), "No se han conseguido enviar los fondos");
        devolucionesPendientes[msg.sender] = 0;
    }

    // Sin require
    function finalizarSubasta() public soloPropietario {
        if (finSubasta > block.timestamp) {
            revert SubastaNoFinalizadaTodavia();    
        }
        
        if(finalizada) {
            revert FinSubastaYaLlamado();
        }

        finalizada = true;
        beneficiario.transfer(mejorOferta);

        emit SubastaFinalizada(mejorPostor, mejorOferta);
    }

    // Con require
    function finalizarSubasta2() public soloPropietario {

    }

}
