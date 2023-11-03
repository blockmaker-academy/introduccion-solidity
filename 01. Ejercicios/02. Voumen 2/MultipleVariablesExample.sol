// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultipleVariablesExample {
    struct Person {
        string name;
        uint256 age;
        address addr;
    }

    function getPersonInfo(string memory _name, uint256 _age, address _addr) public pure returns (string memory, uint256, address) {
        Person memory person = Person(_name, _age, _addr);
        return (person.name, person.age, person.addr);
    }
}