pragma solidity ^0.5.3;

/*
  Because we use uint64 here the balance wraps at certain value
  without assert:
  sent 10 eth to the contract twice => the balance won't be 20
  with assert:
  second time sending 10 eth throws error
*/

contract AssertExample {
    mapping(address => uint64) public balanceReceived;
    
    function receiveMoney() public payable {
      assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);
      balanceReceived[msg.sender] += uint64(msg.value);
    }
    
    function withdrawMoney(address payable _to, uint64 _amount) public {
      require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");
      balanceReceived[msg.sender] -= _amount;
      _to.transfer(_amount);
    }
}
