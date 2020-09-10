pragma solidity 0.5.12;
import './destroyable.sol';

contract helloWorld is destroyable{

  struct Person {
    uint id;
    string name;
    uint age;
    uint height;
  }

  uint public balance;

  modifier costs(uint cost){
        require(msg.value >= cost);
        _;
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

    }
    function insertPerson(Person memory newPerson) private {
           address creator = msg.sender;
           people[creator] = newPerson;
       }

       function getPerson() public view returns(string memory name, uint age, uint height){
           address creator = msg.sender;
           return (people[creator].name, people[creator].age, people[creator].height);
       }

      function getCreator(uint index) public view onlyOwner returns(address){
          return creators[index];
      }
      function withdrawAll() public onlyOwner returns(uint) {
          uint toTransfer = balance;
          balance = 0;
          msg.sender.transfer(balance);
          return toTransfer;
      }

}
