pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/AvailabilityContract.sol";

contract AvailabilityContractTest {
    // Truffle will send the TestContract one Ether after deploying the contract.
    uint public initialBalance = 2 ether;

    function testInitialPrice() public {
        AvailabilityContract avail = new AvailabilityContract(DeployedAddresses.AvailabilityContract(),200 ether);
        Assert.equal(avail.getPrice(), 200 ether, "Expected price like constructor");
    }

    function testChangePrice() public {
        AvailabilityContract avail = new AvailabilityContract(DeployedAddresses.AvailabilityContract(),200 ether);
        avail.changePrice(300 ether);
        Assert.equal(avail.getPrice(), 300 ether, "Expected price");
    }

//    function testLockAndRelease() public {
//        AvailabilityContract avail = AvailabilityContract(DeployedAddresses.AvailabilityContract());
//        avail.lock.gas(200000).value(200)();
//    }

}