pragma solidity ^0.5.10;

contract SimpleStorage {
    uint number;

    function set(uint x) public {
        number = x;
    }

    function get() public view returns (uint) {
        return number;
    }
}