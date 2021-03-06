pragma solidity ^0.8.2;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
    
    function setMyAddresssToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}
