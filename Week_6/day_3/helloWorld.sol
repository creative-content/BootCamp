pragma solidity 0.5.12;
import './destroy.sol';

contract helloWorld is destroy{

  struct Person {
    uint id;
    string name;
    uint age;
    uint height;
  }

  mapping (address => Person) private people;
  address[] private creators;

    function createPerson(string memory name, uint age, uint height) public payable costs(1 ether){
      require(msg.value>=1 ether);

        Person memory newPerson;
          newPerson.name=name;
          newPerson.age=age;
          newPerson.height=height;

    insertPerson(newPerson);
    creators.push(msg.sender);

    emit personCreated(newPerson.name);
    }

}
