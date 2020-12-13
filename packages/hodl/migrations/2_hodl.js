const Hodl = artifacts.require('Hodl');
const DaiToken = artifacts.require('DaiToken');

module.exports = async function(deployer, _network, accounts) {
  // Use deployer to state migration tasks.
  await deployer.deploy(DaiToken);
  const daiToken = await DaiToken.deployed();

  await deployer.deploy(Hodl, daiToken.address);

  // Transfer 100 Mock DAI tokens to investor
  await daiToken.transfer(accounts[1], '100000000000000000000');
};
