pragma solidity ^0.4.19;

interface AvailabilityI{
    function getPrice() public returns (uint256);

    function lock() public payable;

    function purchase() public;

    function abort() public;

    function invalidate() public;
}