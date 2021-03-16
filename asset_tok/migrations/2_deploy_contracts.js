var MyToken = artifacts.require("../client/src/contracts/MyToken");

module.exports = async (deployer) => {
  await deployer.deploy(MyToken);
};
