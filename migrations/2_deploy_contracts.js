var AvailabilityContract =artifacts.require("AvailabilityContract.sol");
var HotelContract =artifacts.require("HotelContract.sol");
var MainContract =artifacts.require("MainContract.sol");
var RoomContract =artifacts.require("RoomContract.sol");

var AddressSet =artifacts.require("AddressSet.sol");

module.exports = function(deployer) {
  deployer.deploy(AddressSet);
  deployer.deploy(AvailabilityContract,0x00,200000);
  deployer.link(AddressSet,HotelContract);
  deployer.deploy(HotelContract,0x00);
  deployer.link(AddressSet,MainContract);
  deployer.deploy(MainContract);
  deployer.link(AddressSet,RoomContract);
  deployer.deploy(RoomContract,0x00);
};
