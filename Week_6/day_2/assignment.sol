pragma solidity 0.5.12;

contract MyContract {
    uint[] private list;

    struct Item {
        bool valid;
        uint index;
        uint age;
        uint height;

        string name;
    }

    event personDataEntered(string name, uint age, uint height);
    mapping(uint => Item) public data;



    /* Update or insert an item */
    function person(uint ID, uint age, uint height, string calldata name) external {
        Item storage item = data[ID];
        if (!item.valid) {
            item.valid = true;
            item.index = list.length;
            list.push(ID);
        }
        item.age = age;
        item.height = height;
        item.name = name;

         assert(keccak256(abi.encodePacked(name,age,height))==keccak256(abi.encodePacked(name,age,height)));
         emit personDataEntered(name,age,height);
    }

    //function count() external view returns (uint index) {
        //return list.length;
    //}
  }
