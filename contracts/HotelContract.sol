pragma solidity ^0.4.11;

contract HotelContract {
    address public admin;//Admin address
    address public hotel = 0x01;//Hotel address
    address[] public rooms;

    function HotelContract() public payable {
        //HotelByte admin address is the creator of first contract
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
        rooms.push(roomAddress);
    }

    function removeRoom(address roomAddress)
    public
    onlyAdminOrHotel
    {
        RemoveRoom();
        uint i = IndexOf(rooms, roomAddress);
        RemoveByIndex(i);
    }

    /** Finds the index of a given value in an array. */
    function IndexOf(address[] array, address value)
    private
    pure
    returns (uint)
    {
        uint i = 0;
        while (array[i] != value) {
            i++;
        }
        return i;
    }

    /** Removes the value at the given index in an array. */
    function RemoveByIndex(uint i)
    private
    {
        while (i < rooms.length - 1) {
            rooms[i] = rooms[i + 1];
            i++;
        }
        rooms.length--;
    }
}
