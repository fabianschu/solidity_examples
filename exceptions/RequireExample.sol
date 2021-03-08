pragma solidity ^0.8.2;

/*
  require => meant for input validation
  remaining gas is paid back
*/

contract RequireExample {
    mapping(address => uint) public balanceReceived;
    
    function receiveMoney() public payable {
      balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
      require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");
      balanceReceived[msg.sender] -= _amount;
      _to.transfer(_amount);
    }
}
