var AvailabilityContract =artifacts.require("AvailabilityContract.sol");
var HotelContract =artifacts.require("HotelContract.sol");
var MainContract =artifacts.require("MainContract.sol");
var RoomContract =artifacts.require("RoomContract.sol");

var AddressSet =artifacts.require("AddressSet.sol");

module.exports = (deployer, network, accounts) => {
  const adminAddress = accounts[0];
  const deployAddress = accounts[1];

  deployer.deploy(AddressSet,{from: deployAddress});
  deployer.deploy(AvailabilityContract,adminAddress,200000,{from: deployAddress});
  deployer.link(AddressSet,HotelContract);
  deployer.deploy(HotelContract,adminAddress,{from: deployAddress});
  deployer.link(AddressSet,MainContract);
  deployer.deploy(MainContract,{from: deployAddress});
  deployer.link(AddressSet,RoomContract);
};
