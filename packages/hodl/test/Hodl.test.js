const Hodl = artifacts.require('Hodl');
const DaiToken = artifacts.require('DaiToken');

contract('Hodl', (accounts) => {
  let instance, daiToken;
  const owner = accounts[0];

  beforeEach(async () => {
    daiToken = await DaiToken.new();
    instance = await Hodl.new(daiToken.address, { from: owner });
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

  it('should withdraw amount and update the balance of the sender', async () => {
    const startingBalance = 15;
    const amountToWithdraw = 5;
    const expectedBalance = 10;

    await instance.deposit(startingBalance);
    await instance.withdraw(amountToWithdraw);
    const actualBalance = await instance.getBalance();

    assert.equal(actualBalance, expectedBalance);
  });

  it('should not allow senders to deposit a negative amount', async () => {
    const amountToDeposit = -1; 

    await instance.deposit(amountToDeposit);
  });

});
