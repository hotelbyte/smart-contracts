pragma solidity ^0.4.19;

import "libs/AddressSet.sol";
import "interfaces/RoomI.sol";
import "interfaces/AvailabilityI.sol";

contract RoomContract is RoomI {
    address admin;//Admin address
    address hotel;//Hotel address
    AddressSet.Data availabilities;
    //TODO Fill Hotel level info

    function RoomContract(address adminAddress) public payable {
        hotel = msg.sender;
        admin = adminAddress;
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
    event Purchase();

    function addAvailability(address availabilityAddress)
    public
    onlyAdminOrHotel
    {
        AddRoom();
        require(AddressSet.insert(availabilities, availabilityAddress));
    }

    function removeAvailability(address availabilityAddress)
    public
    onlyAdminOrHotel
    {
        RemoveRoom();
        require(AddressSet.remove(availabilities, availabilityAddress));
    }

    function purchase(address[] availabilitiesArray)
    public
    payable
    {
        Purchase();
        //Obtain total price
        uint i = 0;
        uint256 price = 0;

        AvailabilityI availability;
        while (i < availabilitiesArray.length) {

            availability = AvailabilityI(availabilitiesArray[i]);
            uint256 availPrice=availability.getPrice();
            price += availPrice;
            //Lock the availability until all checks are done & transfer price funds
            availability.lock.value(availPrice)();
            //TODO Here can fail if availability is already taken
            i++;
        }

        //Check if payed amount are correct
        if (msg.value != price){
            //Revert locks
            i = 0;
            while (i < availabilitiesArray.length) {
                availability = AvailabilityI(availabilitiesArray[i]);
                availability.abort();
            }
        }
        require(msg.value == price);

        //Purchase all availabilities
        i = 0;
        while (i < availabilitiesArray.length) {
            availability = AvailabilityI(availabilitiesArray[i]);
            availability.purchase();
        }
    }
}
