pragma solidity ^0.8.0;

contract WalletLibrary {
     address owner;

     function initWallet(address _owner) public {
         owner = _owner;
         // ... more setup ...
     }

     function getOwnership() public view returns(address){
         return owner;
     }
     function changeOwner(address _new_owner) external {
         if (msg.sender == owner) {
             owner = _new_owner;
         }
     }

     fallback () external payable {
         
     }
     receive () external payable {
         
     }
     

     function withdraw(uint amount) external returns (bool success) {
         if (msg.sender == owner) {
             return payable(owner).send(amount);
         } else {
             return false;
         }
     }
}

contract Wallet {
    address _walletLibrary;

    constructor(address libAddress) {
        _walletLibrary = libAddress;
 
        address(_walletLibrary).delegatecall(abi.encodePacked(bytes4(keccak256("initWallet(address)")),msg.sender));
    }
    
    function getOwnership() public returns (bytes memory owner){
        (,owner ) = address(_walletLibrary).delegatecall(abi.encodePacked(bytes4(keccak256("getOwnership()"))));
        return owner;
    }

    
    function withdraw(uint amount) public returns (bool success, bytes memory data) {
        return address(_walletLibrary).delegatecall(abi.encodePacked(bytes4(keccak256("withdraw(uint)")), amount));
       
    }

    fallback () external payable {
        address(_walletLibrary).delegatecall(msg.data);
    }
    receive () external payable {
         
     }
}