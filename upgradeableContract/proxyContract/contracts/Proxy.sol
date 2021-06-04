pragma solidity 0.8.0;

import "./Storage.sol";

contract Proxy is Storage{
    
    address currentAddress;

    constructor(address _currentAddress) {
        currentAddress = _currentAddress;
    }

    //when error happens in the current working functional contract, call
    // upgrade() to change to new functional contract address without
    //losing current state
    function upgrade(address _newAddress) public{
        currentAddress = _newAddress;
    }

    fallback() external payable{
        require(currentAddress != address(0));
        address implementation = currentAddress; 
        bytes memory data = msg.data; // all the info of the fucntion call

        assembly{
            let result := delegatecall(gas(), implementation, add(data,0x20), mload(data) , 0, 0)
            let size := returndatasize()
            let ptr := mload(0x40) //consult this location if we can save this varible
            returndatacopy(ptr, 0, size)
            switch result
            case 0 {revert(ptr,size)} //failed
            default {return(ptr, size)} //succeed

        }
    }


    // receive() external payable{
        
    // }



}