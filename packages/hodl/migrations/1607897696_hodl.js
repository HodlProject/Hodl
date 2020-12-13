const Hodl = artifacts.require('Hodl');

module.exports = function(_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(Hodl);
};
