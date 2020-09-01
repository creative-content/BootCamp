pragma solidity 0.5.12;

contract hello_world{

 struct Person {
      uint id;
      string name;
      uint age;
      uint height;
    }

    Person[] public people;

        function createPerson(string memory name, uint memory age, uint memory height) public{

        Person memory newPerson;
        newPerson.id=people.length;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;
        people.push(newPerson);
        }
}
