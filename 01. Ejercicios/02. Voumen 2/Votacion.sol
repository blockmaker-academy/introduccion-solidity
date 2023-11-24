// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Votacion {
    address public presidente;

    struct Votante {
        uint256 peso; // 1: puedo votar una vez
        bool votado; // true/false: si puedo votar
        address delegado; // "0x53234"
        uint256 voto; // 1
    }

    struct Propuesta {
        string nombre; // Candidatos (e.g., "Feijó")
        uint256 cantidadVotos; // 2
    }

    mapping(address => Votante) public votantes; // votantes[votante].votado

    Propuesta[] public propuestas; // [Propuesta1, Propuesta2]

    event DerechoVotoOtorgado(address indexed votante);
    event VotoDelegado(address indexed remitente, address indexed delegado);
    event VotoEmitido(address indexed votante, uint256 indexed propuesta);

    modifier soloPresidente() {
        require(msg.sender == presidente, "No eres el presidente");
        _;
    }

// Descripción:
// Igualamos la variable presidente al propio emisor del despliegue.
// Ahora, deberemos introducir todos los nombres de propuestas que nos han llegado en el array de string (string[]) llamado propuestas.
// Realizamos un bucle for() que comience por 0 y finalice cuando el valor de la variable que declaremos “i” sea < nombresPropuestas.length (longitud máxima del array).
// Dentro del propio bucle, lo que haremos será introducir dentro del array propuestas un objeto/struct por nombre que nos ha llegado en nombrePropuestas.
// Para ello utilizaremos la función push() de los arrays, con el fin de introducirle las Propuestas (propuestas.push(<INTRODUCIR_STRUCT_PROPUESTA*).

// *Al introducir el objeto Propuesta, estableceremos el “nombre” como “nombrePropuestas[i]” (con la variable que recorremos el array de nombres) y la “cantidadVotos” la pondremos a 0.


    constructor(string[] memory _nombrePropuestas) {
        presidente = msg.sender;
        for(uint256 i=0; i < _nombrePropuestas.length; i++) {
            propuestas.push(Propuesta(
                _nombrePropuestas[i],
                0
            ));
            // Opción 2
            // propuestas.push(Propuesta({
            //    nombre: _nombrePropuestas[i],
            //    cantidadVotos: 0
            // }));
        }
    }

    // 1. Comprobamos que el votante no haya votado, es decir, miramos dentro del mapping votantes, si el votante tiene la variable votado a “true”.
    // 2. Comprobamos que al votante no se le haya asignado el derecho a votar previamente, es decir, miramos dentro del mapping votantes, si el votante tiene la variable peso a 0.
    // 3. Ahora añadiros al array de votantes al propio votante accediendo a su variable peso y asignándole valor 1 (votantes[votante].peso).
    // 4. Por último, emitimos el evento DerechoDeVotoOtorgado.
    function darDerechoAVotar(address _votante) public soloPresidente {
        // require(caso true, caso false)
        require(!votantes[_votante].votado, "El usuario ya ha votado anteriormente");
        require(votantes[_votante].peso == 0, "Al usuario ya se le ha otorgado derecho a votar");
        votantes[_votante].peso = 1;

        emit DerechoVotoOtorgado(_votante);
    }

    function delegar(address _receptor) public {
        // INTRODUCIR COMPROBACIONES

        while(votantes[_receptor].delegado != address(0)) {
            _receptor = votantes[_receptor].delegado;
            // INTRODUCIR COMPROBACIÓN
        }

        // SEGUIR CON EL EJERCICIO
    }

}