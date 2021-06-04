pragma solidity 0.8.0;

import "./Storage.sol";

contract DogUpgraded is Storage{

    modifier onlyOwner{
        require(owner==msg.sender);
        _;
    }

    constructor(){
        initialize(msg.sender);
    }

    function initialize(address _owner) public { // should be only run once
        require(!_initialized);
        owner = _owner;
        _initialized = true;


    }

    function getNumberOfDogs() public view returns(uint){
        return _uintStorage["Dog"];
    }
    function setNumberOfDogs(uint num) public onlyOwner{
        _uintStorage["Dog"] = num;
    }
} 