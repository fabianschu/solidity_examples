pragma solidity ^0.8.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable{
    mapping(address => uint) public allowances;
    
    event NewAllowanceLimit(address _allowanceAddress, uint _maxAllowance);
    
    function setAllowanceLimit(address _allowanceAddress, uint _maxAllowance) public onlyOwner{
        allowances[_allowanceAddress] = _maxAllowance;
        emit NewAllowanceLimit(_allowanceAddress, _maxAllowance);
    }
    
    function withdrawFromAllowance(uint _amount) public {
        require(allowances[msg.sender] >= _amount, "You can't exceed your allowance");
        allowances[msg.sender] -= _amount;
    }
}

contract SharedWallets is Allowance {
    event NewDeposit(uint _amount);
    event TotalBalance(uint _amount);

    function deposit() public payable {
        emit NewDeposit(msg.value);
    }
    
    function getTotalBalance() public {
        emit NewDeposit(address(this).balance);
    }
    
    function withdraw(uint _amount) public {
        require(_amount < address(this).balance, "Not enough total funds");
        
        if(msg.sender != owner()) {
            withdrawFromAllowance(_amount);
        }
        
        payable(msg.sender).transfer(_amount);
    }

    function renounceOwnership() override public pure {
      revert("Ownership cannot be renounced");
    }
    
    receive() external payable {
        emit NewDeposit(msg.value);
    }
}
