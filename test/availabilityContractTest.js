var AvailabilityContract = artifacts.require("AvailabilityContract");

contract('AvailabilityContract', function(accounts) {
    var adminAccount = accounts[0];
    var deployAddress = accounts[1];
    var account_one = accounts[2];
    var account_two = accounts[3];
    it("Test initial price", function() {
        return AvailabilityContract.deployed().then(function(instance) {
            return instance.getPrice.call();
        }).then(function(balance) {
            assert.equal(balance.valueOf(), 200000, "200000 expected");
        });
    });
    it("Test change price", function() {
        var contract;
        return AvailabilityContract.deployed().then(function(instance) {
            contract = instance;
            return contract.changePrice(300000, {
                from: adminAccount
            });
        }).then(function(instance) {
            return contract.getPrice.call();
        }).then(function(balance) {
            assert.equal(balance.valueOf(), 300000, "200000 expected");
            return contract.changePrice(200000, {
                from: deployAddress
            });
        }).then(function(instance) {
            return contract.getPrice.call();
        }).then(function(balance) {
            assert.equal(balance.valueOf(), 200000, "200000 expected");
            return contract.changePrice(300000, {
                from: account_one
            });
        }).then(function(balance) {
            assert(false, "It shouldn't be possible to changePrice from a non admin account");
        }).catch(function(e) {
            if (e.toString().indexOf("AssertionError") != -1) {
                assert(false, e.toString());
            }
            //console.log("Expected error OK! " + e);
        });
    });
    it("Test lock & unlock", function() {
        var contract;

        return AvailabilityContract.deployed().then(function(instance) {
            contract = instance;
            //console.log("Balance of contract " + web3.eth.getBalance(contract.address));
            return contract.lock({
                from: account_one,
                value: 200000
            });
        }).then(function(instance) {
            var contract_balance = web3.eth.getBalance(contract.address);
            //console.log("Balance of contract " + contract_balance);
            assert.equal(contract_balance, 200000, "200000 expected balance for contract after lock");
            return contract.unlock({
                from: account_two
            });
        }).then(function(balance) {
            assert(false, "It shouldn't be possible to unlock from a different account");
        }).catch(function(e) {
            if (e.toString().indexOf("AssertionError") != -1) {
                assert(false, e.toString());
            }
            //console.log("Expected error OK! " + e);
            return contract.unlock({
                from: account_one
            });
        }).then(function(balance) {
            var contract_balance = web3.eth.getBalance(contract.address);
            //console.log("Balance of contract " + contract_balance);
            assert.equal(contract_balance, 0, "0 expected balance for contract after unlock");
            return contract.lock({
                from: account_two,
                value: 200000
            });
        }).then(function(instance) {
            var contract_balance = web3.eth.getBalance(contract.address);
            //console.log("Balance of contract " + contract_balance);
            assert.equal(contract_balance, 200000, "200000 expected balance for contract after lock");

            return contract.unlock({
                from: account_two
            });
        }).then(function(balance) {
            var contract_balance = web3.eth.getBalance(contract.address);
            //console.log("Balance of contract " + contract_balance);
            assert.equal(contract_balance, 0, "0 expected balance for contract after unlock");
        });
    });
});