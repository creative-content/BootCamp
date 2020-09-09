pragma solidity 0.5.12;

contract ownable{
  address public owner;

  modifier onlyOwner(){
    require(msg.sender==owner);
    _;
  }

  constructor() public{
    owner=msg.sender;
  }

}
