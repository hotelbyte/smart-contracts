pragma solidity ^0.4.19;

interface RoomI {

    function addAvailability(address availabilityAddress) public;

    function removeAvailability(address availabilityAddress) public;

    function purchase(address[] availabilitiesArray) public payable;
}