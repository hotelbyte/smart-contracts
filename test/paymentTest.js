// Specifically request an abstraction for MetaCoin
var AvailabilityContract = artifacts.require("AvailabilityContract");
//accounts[0]

contract('AvailabilityContract', function(accounts) {
  it("Test initial price", function() {
    return AvailabilityContract.deployed().then(function(instance) {
      return instance.getPrice.call();
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 200, "200 expected");
    });
  });
//  it("Test lock & unlock", function() {
//    var account_one = accounts[0];
//    var account_two = accounts[1];
//
//     return AvailabilityContract.deployed().then(function(instance) {
//        return instance.lock({
//                                       from: account_one,
//                                       gas: 4712388,
//                                       value: 200
//                                     });
//     }).then(function(balance) {
//        assert.equal(1, 1, "200 expected");
//     });
//  });
});