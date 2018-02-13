// Specifically request an abstraction for MetaCoin
var AvailabilityContract = artifacts.require("AvailabilityContract");

contract('AvailabilityContract', function(accounts) {
  it("Test initial price", function() {
    return AvailabilityContract.deployed().then(function(instance) {
      return instance.getPrice.call();
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 200000, "200000 expected");
    });
  });
  it("Test lock & unlock", function() {
    var contract;
    var account_one = accounts[0];
    var account_two = accounts[1];

    return AvailabilityContract.deployed().then(function(instance) {
        contract=instance;
        console.log ("Balance of contract " +web3.eth.getBalance(contract.address));
        return contract.lock({
                         from: account_one,
                         value: 200000
                      });
    }).then(function(instance) {
        var contract_balance=web3.eth.getBalance(contract.address);
        console.log ("Balance of contract " +contract_balance);
        assert.equal(contract_balance, 200000, "200000 expected balance for contract after lock");

        return contract.unlock.call({from: account_two});
    }).then(function(balance) {
       assert(false,"It shouldn't be possible to unlock from a different account");
    }).catch(function(e) {
        if(e.toString().indexOf("AssertionError") != -1) {
            assert(false,e.toString());
        }
        console.log ("Expected error OK! "+e);
        console.log ("Balance of user " +web3.eth.getBalance(account_one));
        return contract.unlock.call({from: account_one});
     }).then(function(balance) {
        var contract_balance=web3.eth.getBalance(contract.address);
        console.log ("Balance of user " +web3.eth.getBalance(account_one));
        console.log ("Balance of contract " +contract_balance);
//        assert.equal(contract_balance, 0, "0 expected balance for contract after unlock");
     });
  });
});