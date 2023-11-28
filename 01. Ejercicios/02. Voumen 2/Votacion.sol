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


    constructor(string[] memory _nombrePropuestas) { // ["Feijó", "Pedro", "Abascal"]
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
        require(votantes[msg.sender].peso != 0, "No tiene derecho a votar ni delegar");
        require(!votantes[msg.sender].votado, "Ya has votado");
        require(msg.sender != _receptor, "Estas delegando en ti mismo");

        // Iván delega en Laura => Laura delega en Pedro => Pedro no delega (nuevo _receptor)
        while(votantes[_receptor].delegado != address(0)) {
            _receptor = votantes[_receptor].delegado;
            require(_receptor != msg.sender, "No se admiten bucles hacia el emisor");
        }
        require(votantes[_receptor].peso >= 1, "No tiene derecho a votar");

        votantes[msg.sender].votado = true;
        votantes[msg.sender].delegado = _receptor;

        if(votantes[_receptor].votado) { // Pedro ha votado a Feijó | Feijó tiene 5 votos | Laura delega en Pedro 1 voto => Feijó tiene 6 votos
            propuestas[votantes[_receptor].voto].cantidadVotos += votantes[msg.sender].peso;
        }
        else {
            votantes[_receptor].peso += votantes[msg.sender].peso;
        }

        emit VotoDelegado(msg.sender, _receptor);
    }

    // Comprobamos que al votante se le haya asignado el derecho a votar previamente, es decir, miramos dentro del mapping votantes, si el votante tiene la variable peso  != 0 o >0.
    // Comprobamos que el votante no haya votado (del msg.sender), es decir, miramos dentro del mapping votantes si el votante tiene la variable votado a “true”.
    // Tras estas comprobaciones, ponemos al votante con la variable votado a true.
    // Ponemos al votante con la variable voto = a la proposición realizada.
    // Actualizamos la cantidadVotos dentro del array de propuestas el correspondiente al índice de la proposición (propuestas[proposicion]) que nos han pasado con el peso total que tenía el votante (votantes[msg.sender]).
    // Por último, emitimos el evento VotoEmitido.
    function votar(uint256 _proposicion) public {
        require(votantes[msg.sender].peso > 0, "No tienes derecho a votar");
        require(!votantes[msg.sender].votado, "Ya has votado");

        votantes[msg.sender].votado = true;
        votantes[msg.sender].voto = _proposicion;

        propuestas[_proposicion].cantidadVotos += votantes[msg.sender].peso;

        emit VotoEmitido(msg.sender, _proposicion);
    }

    function propuestaGanadora() private view returns(uint256) {
        uint256 cantidadVotosGanadores = 0;
        uint256 indicePropuestaGanadora = 0;
        for(uint256 i = 0; i < propuestas.length; i++) {
            if(propuestas[i].cantidadVotos > cantidadVotosGanadores) {
                cantidadVotosGanadores = propuestas[i].cantidadVotos;
                indicePropuestaGanadora = i;
            }
        }
        // Propuesta("Pedro", 5) | Propuesta("Feijó", 6)
        return indicePropuestaGanadora;
    }

    function nombreGanador() public view returns(string memory) {
        return propuestas[propuestaGanadora()].nombre;
    }

    function devolverStruct() public view returns(Votante memory, Votante memory) {
        // return(Votante(0, false, address(0), 1));
        return(
            votantes[msg.sender],
            Votante(0, false, address(0), 1)
        );
    }


}