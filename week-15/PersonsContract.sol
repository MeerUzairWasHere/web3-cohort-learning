// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PersonsContract {
    struct Person {
        string name;
        uint age;
        string email;
        bool exists;
    }

    mapping(address => Person) private persons;
    address[] private personAddresses;

    event PersonAdded(address indexed personAddress, string name, uint age);
    event PersonUpdated(address indexed personAddress, string name, uint age);

    function addPerson(
        string memory _name,
        uint _age,
        string memory _email
    ) external {
        require(
            !persons[msg.sender].exists,
            "Person already exists for this address"
        );

        persons[msg.sender] = Person(_name, _age, _email, true);
        personAddresses.push(msg.sender);

        emit PersonAdded(msg.sender, _name, _age);
    }

    function updatePerson(
        string memory _name,
        uint _age,
        string memory _email
    ) external {
        require(persons[msg.sender].exists, "Person does not exist");

        persons[msg.sender].name = _name;
        persons[msg.sender].age = _age;
        persons[msg.sender].email = _email;

        emit PersonUpdated(msg.sender, _name, _age);
    }

    function getPerson(
        address _address
    ) external view returns (string memory, uint, string memory, bool) {
        Person memory person = persons[_address];
        return (person.name, person.age, person.email, person.exists);
    }

    function getAllPersonAddresses() external view returns (address[] memory) {
        return personAddresses;
    }

    function getPersonCount() external view returns (uint) {
        return personAddresses.length;
    }
}
