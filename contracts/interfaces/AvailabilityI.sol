pragma solidity ^0.4.19;

interface AvailabilityI{
    function getPrice() public returns (uint256);

    function changePrice(uint changedPrice) public;

    function lock() public payable;

    function unlock() public;

    function purchase() public;

    function invalidate() public;
}