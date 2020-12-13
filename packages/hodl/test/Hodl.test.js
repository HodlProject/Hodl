const Hodl = artifacts.require('Hodl');

contract('Hodl', (accounts) => {
  let instance;
  const owner = accounts[0];

  beforeEach(async () => {
    instance = await Hodl.new({ from: owner });
  });

  it('should deploy', async () => {
    assert(instance.address !== '');
  });

  it('should deposit amount and assign the amount to the sender', async () => {
    const amountDeposited = 15;

    await instance.deposit(amountDeposited);
    const actualBalance = await instance.getBalance();

    assert.equal(actualBalance, amountDeposited);
  });

});
