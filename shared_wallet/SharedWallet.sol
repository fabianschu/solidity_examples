pragma solidity ^0.8.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SharedWallets is Ownable {
    
    struct Wallet {
        uint maxAllowance;
        uint usedAllowance;
    }
    mapping(address => Wallet) public allowances;
    
    event NewDeposit(uint _amount);
    event TotalBalance(uint _amount);
    event NewAllowanceLimit(address _allowanceAddress, uint _maxAllowance);
    event ResetAllowanceLimit(address _allowanceAddress);
    
    function deposit() public payable {
        emit NewDeposit(msg.value);
    }
    
    function getTotalBalance() public {
        emit NewDeposit(address(this).balance);
    }
    
    function withdrawFromAllowance(uint _amount) public {
        require(_amount < address(this).balance, "Not enough total funds");
        
        if(msg.sender != owner()) {
            uint targetAllowance =  allowances[msg.sender].usedAllowance + _amount;
            require(targetAllowance <= allowances[msg.sender].maxAllowance, "You can't exceed your allowance");
            allowances[msg.sender].usedAllowance = targetAllowance;
        }
        
        payable(msg.sender).transfer(_amount);
    }
    
    function resetAllowanceLimit(address _walletAddress) public onlyOwner {
        allowances[_walletAddress].usedAllowance = 0;
        emit ResetAllowanceLimit(_walletAddress);
    }
    
    function setAllowanceLimit(address _allowanceAddress, uint _maxAllowance) public onlyOwner{
        allowances[_allowanceAddress].maxAllowance = _maxAllowance;
        emit NewAllowanceLimit(_allowanceAddress, _maxAllowance);
    }
    
    receive() external payable {
        emit NewDeposit(msg.value);
    }
}
