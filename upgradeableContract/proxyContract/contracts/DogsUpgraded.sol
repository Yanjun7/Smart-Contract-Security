pragma solidity 0.8.0;

import "./Storage.sol";

contract DogUpgraded is Storage{

    modifier onlyOwner{
        require(owner==msg.sender);
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function getNumberOfDogs() public view returns(uint){
        return _uintStorage["Dog"];
    }
    function setNumberOfDogs(uint num) public onlyOwner{
        _uintStorage["Dog"] = num;
    }
} 