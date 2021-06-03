pragma solidity ^0.8.0;

contract Fundraiser{
    mapping(address=> uint) balances;
    
    function contribute() payable public{
        balances[msg.sender]+=msg.value;
        
    }
    
    function withdraw() public{
        require(balances[msg.sender]>0, "no funds");
        (bool success, ) = msg.sender.call{value:balances[msg.sender]}("");  //problematic!
        require(success, "withdraw failed"); /// before reach this line, the attacker may have recursively call the withdra() finction many times!
        balances[msg.sender] = 0;  
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
}
