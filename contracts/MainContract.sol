pragma solidity ^0.4.19;

import "libs/AddressSet.sol";
import "interfaces/MainI.sol";

contract MainContract is MainI {
    address admin;//Admin address
    AddressSet.Data  hotels;

    function MainContract() public payable {
        //HotelByte admin address is the creator of first contract
        admin = msg.sender;
    }

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin);
        _;
    }

    event AddHotel();
    event RemoveHotel();


    function addHotel(address hotelAddress)
    public
    onlyAdmin
    {
        AddHotel();
        require(AddressSet.insert(hotels, hotelAddress));
    }

    function removeHotel(address hotelAddress)
    public
    onlyAdmin
    {
        RemoveHotel();
        require(AddressSet.remove(hotels, hotelAddress));
    }

}