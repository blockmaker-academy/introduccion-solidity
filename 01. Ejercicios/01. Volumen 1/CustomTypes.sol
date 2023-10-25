// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CustomTypes {
    // Define custom type aliases
    type MyInt is uint256;

    // Example function using custom types
    function addInts(MyInt a, MyInt b) public pure returns (MyInt) {
        return MyInt.wrap(MyInt.unwrap(a) + MyInt.unwrap(b));
    }
}
