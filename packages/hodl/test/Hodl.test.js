const Hodl = artifacts.require('Hodl');

contract('Hodl', (accounts) => {

  it('should deploy', async () => {
    // deployed()  does not deploy a contract by itself. It only
    // returns a js object pointing to an already deployed smart contract
    // migrations are used to define what should be deployed
    const instance = await Hodl.deployed();

    console.log(instance.address);

    assert(instance.address !== '');
  });

});
