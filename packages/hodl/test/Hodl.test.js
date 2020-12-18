const Hodl = artifacts.require('Hodl');
const DaiToken = artifacts.require('DaiToken');

function tokens(n) {
  return web3.utils.toWei(n, 'ether');
}

contract('Hodl', ([owner, investor]) => {
  let instance, daiToken;

  beforeEach(async () => {
    daiToken = await DaiToken.new();
    instance = await Hodl.new(daiToken.address, { from: owner });

    // await daiToken.transfer(investor, tokens('100'), { from: owner })
  });

  it('should deploy', async () => {
    assert(instance.address !== '');
  });

  it('should deposit amount and assign the amount to the sender', async () => {
    const amountDeposited = 15;

    await instance.deposit(amountDeposited, { from: investor });
    const actualBalance = await instance.getBalance({ from: investor });

    assert.equal(actualBalance, amountDeposited);
  });

  it('should withdraw amount and update the balance of the sender', async () => {
    const startingBalance = 15;
    const amountToWithdraw = 5;
    const expectedBalance = 10;

    await instance.deposit(startingBalance, { from: investor });
    await instance.withdraw(amountToWithdraw, { from: investor });
    const actualBalance = await instance.getBalance({ from: investor });

    assert.equal(actualBalance, expectedBalance);
  });

});
