pragma solidity ^0.8.2;



contract FunctionExample {
    mapping(address => uint) public balanceReceived;
    address payable owner;
    
    /*
        contructor is run once at time of deployment
    */
    
    constructor() {
        owner = payable(msg.sender);
    }
    
    /*
        read only functions
    */
    
    function getOwner() public view returns (address) {
        return owner;
    }
    
    /*
        pure function => doesn't interact with storage variables
    */
    
    function convertWeiToEther(uint _amountInWei) public pure returns (uint) {
        return _amountInWei / 1 ether;
    }
    
    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }
    
    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "You don't have enough ether");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    
    /*
        if I send ether directly to the contractthe transaction will fail
        if not fallback (or receive) function is specified
    */
    
    receive () external payable {
        receiveMoney();
    }
}
