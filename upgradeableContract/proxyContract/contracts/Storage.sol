pragma solidity 0.8.0;

contract Storage{

    mapping(string=>address) _addressStorage;
    mapping(string=>uint256) _uintStorage;
    mapping(string=>string) _stringStorage;
    mapping(string=>bool) _boolStorage;
    mapping(string=>bytes4) _bytesStorage;
    address public owner;
    bool public _initialized;
    
}