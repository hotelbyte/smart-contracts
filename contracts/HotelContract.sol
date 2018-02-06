pragma solidity ^0.4.19;

import "libs/AddressSet.sol";
import "interfaces/HotelI.sol";


contract HotelContract is HotelI {
    address admin;//Admin address
    address hotel;//Hotel address
    AddressSet.Data rooms;
    //TODO Fill Hotel level info

    function HotelContract(address hotelAdminAddress) public payable {
        hotel = hotelAdminAddress;
        admin = msg.sender;
    }

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyAdminOrHotel() {
        require(msg.sender == admin || msg.sender == hotel);
        _;
    }

    event AddRoom();
    event RemoveRoom();


    function addRoom(address roomAddress)
    public
    onlyAdminOrHotel
    {
        AddRoom();
        require(AddressSet.insert(rooms, roomAddress));
    }

    function removeRoom(address roomAddress)
    public
    onlyAdminOrHotel
    {
        RemoveRoom();
        require(AddressSet.remove(rooms, roomAddress));
    }
}