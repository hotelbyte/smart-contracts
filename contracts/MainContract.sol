pragma solidity ^0.4.11;


contract MainContract {
    address public admin;//Admin address
    address[] public hotels;

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
        hotels.push(hotelAddress);
    }

    function removeHotel(address hotelAddress)
    public
    onlyAdmin
    {
        RemoveHotel();
        uint i = IndexOf(hotels, hotelAddress);
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
        while (i < hotels.length - 1) {
            hotels[i] = hotels[i + 1];
            i++;
        }
        hotels.length--;
    }
}
