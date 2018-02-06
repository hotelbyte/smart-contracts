pragma solidity ^0.4.19;

import "interfaces/AvailabilityI.sol";

contract AvailabilityContract is AvailabilityI {
    uint public price;
    address public hotel;
    address public admin;
    address public buyer;
    enum State {Active, Locked, Inactive}
    State public state;

    // Ensure that `msg.value` is an even number.
    // Division will truncate if it is an odd number.
    // Check via multiplication that it wasn't an odd number.
    function AvailabilityContract(address adminAddress) public payable {
        price = msg.value / 2;
        require((2 * price) == msg.value);
        hotel = msg.sender;
        admin = adminAddress;
    }

    modifier condition(bool _condition) {
        require(_condition);
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }

    modifier onlyAdmin() {
        require( msg.sender == hotel || msg.sender == admin);
        _;
    }

    modifier onlyBuyerOrAdmin() {
        require(msg.sender == buyer || msg.sender == hotel || msg.sender == admin);
        _;
    }

    modifier inState(State _state) {
        require(state == _state);
        _;
    }


    event Lock();
    event Purchase();
    event Invalidate();
    event Abort();

    function getPrice() public returns (uint256){
        return price;
    }

    function lock()
    public
    inState(State.Active)
    condition(msg.value == (2 * price))
    payable
    {
        Lock();
        buyer = msg.sender;
        state = State.Locked;
    }

    function invalidate()
    public
    onlyAdmin
    inState(State.Active)
    {
        Invalidate();
        state = State.Inactive;
        hotel.transfer(this.balance);
    }

    function abort()
    public
    onlyBuyerOrAdmin
    inState(State.Locked)
    {
        Abort();
        state = State.Active;
        buyer.transfer(this.balance);
        delete buyer;
    }


    function purchase()
    public
    onlyBuyer
    inState(State.Locked)
    {
        Purchase();
        // It is important to change the state first because
        // otherwise, the contracts called using `send` below
        // can call in again here.
        state = State.Inactive;
        hotel.transfer(this.balance);
    }
}