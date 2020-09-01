pragma solidity 0.5.12;

contract HelloWorld{

    struct Person {
      uint id;
      string name;
      uint age;
      uint height;
      bool senior;
    }

    address public owner;

    constructor() public{
        owner = msg.sender;
    }

    mapping (address => Person) private people;
    address[] private creators;

    function createPerson(string memory name, uint age, uint height) public {
      require(age < 150, "Age needs to be below 150");
        //This creates a person
        Person memory newPerson;
        newPerson.name = name;
        newPerson.age = age;
        newPerson.height = height;

        if(age >= 65){
           newPerson.senior = true;
       }
       else{
           newPerson.senior = false;
       }

        insertPerson(newPerson);
        creators.push(msg.sender);

        assert(
            keccak256(
                abi.encodePacked(
                    people[msg.sender].name,
                    people[msg.sender].age,
                    people[msg.sender].height,
                    people[msg.sender].senior
                )
            )
            ==
            keccak256(
                abi.encodePacked(
                    newPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );
    }

    function insertPerson(Person memory newPerson) private {
        address creator = msg.sender;
        people[creator] = newPerson;
    }
    function getPerson() public view returns(string memory name, uint age, uint height, bool senior){
        address creator = msg.sender;
        return (people[creator].name, people[creator].age, people[creator].height, people[creator].senior);
    }
    function updatePerson(string memory name, uint age, uint height) public {
      require(age < 150, "Age needs to be below 150");
        //This updates a person
        Person memory changePerson;
        changePerson.name = name;
        changePerson.age = age;
        changePerson.height = height;

        if(age >= 65){
           changePerson.senior = true;
       }
       else{
           changePerson.senior = false;
       }

        insertChangedPerson(changePerson);
        creators.push(msg.sender);

        assert(
            keccak256(
                abi.encodePacked(
                    changePerson.name,
                    changePerson.age,
                    changePerson.height,
                    changePerson.senior
                )
            )
            !=
            keccak256(
                 abi.encodePacked(
                    newPersonPerson.name,
                    newPerson.age,
                    newPerson.height,
                    newPerson.senior
                )
            )
        );
    }

    function insertChangedPerson(Person memory changePerson) private {
        address creator = msg.sender;
        people[creator] = changePerson;
    }
    function deletePerson(address creator) public {
       require(msg.sender == owner, "Caller needs to be owner");
       delete people[creator];
       assert(people[creator].age == 0);
   }

   function getCreator(uint index) public view returns(address){
       require(msg.sender == owner, "Caller needs to be owner");
       return creators[index];
   }


}
