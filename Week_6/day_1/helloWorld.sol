pragma solidity 0.5.12;

contract hello_world{

 struct Person {
      uint id;
      string name;
      uint age;
      uint height;
    }

    Person[] public people;

        function createPerson(string memory name, uint age, uint height) public{

        people.push(Person(people.length, name, age, height));
        }
}
