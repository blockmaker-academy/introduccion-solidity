// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ByteDemo {
    function getBytesLength(bytes memory _bytes) public pure returns (uint) {
        return _bytes.length;
    }
}