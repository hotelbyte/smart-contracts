pragma solidity ^0.4.19;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/libs/ThrowProxy.sol";
import "../contracts/AvailabilityContract.sol";

contract AvailabilityContractRestrictionTest {

    function testUnauthorizedChangePrice() public {
        //Use contract created on migration
        AvailabilityContract avail = AvailabilityContract(DeployedAddresses.AvailabilityContract());

        //Configure the proxy
        ThrowProxy throwProxy = new ThrowProxy(address(avail));
        AvailabilityContract(address(throwProxy)).changePrice(300 ether);

        //Execute the call that is supposed to throw.
        bool result = throwProxy.execute.gas(200000)();

        Assert.isFalse(result, "Should be false, as it should throw");
    }
}

