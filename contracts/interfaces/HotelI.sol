pragma solidity ^0.4.19;

interface HotelI {

    function addRoom(address roomAddress) public;

    function removeRoom(address roomAddress) public;
}