// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeUnitsExample {
    // Function to calculate future timestamps based on different time units
    function calculateFutureTimestamps(uint256 numUnits) public view returns (uint256, uint256, uint256, uint256, uint256) {
        uint256 currentTime = block.timestamp; // Current timestamp in seconds since epoch

        // Calculate future timestamps based on the provided number of units
        uint256 futureTimestampSeconds = currentTime + numUnits * 1 seconds;
        uint256 futureTimestampMinutes = currentTime + numUnits * 1 minutes;
        uint256 futureTimestampHours = currentTime + numUnits * 1 hours;
        uint256 futureTimestampDays = currentTime + numUnits * 1 days;
        uint256 futureTimestampWeeks = currentTime + numUnits * 1 weeks;

        return (
            futureTimestampSeconds,
            futureTimestampMinutes,
            futureTimestampHours,
            futureTimestampDays,
            futureTimestampWeeks
        );
    }
}
# sdsd

block.basefee (uint): comisión base del bloque actual
block.chainid (uint): id actual de la cadena
block.coinbase (address payable): address / dirección del minero del bloque actual
block.difficulty (uint): dificultad actual del bloque
block.gaslimit (uint): límite de gas del bloque actual
block.number (uint): current block number
block.timestamp (uint): tiempo del bloque actual

msg.sender (address): dirección del emisor de la petición / mensaje
msg.value (uint): valor en ether (wei) del mensaje actual

tx.gasprice (uint): precio del gas de la transacción
tx.origin (address): dirección del emisor de la transacción
