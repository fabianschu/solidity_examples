var Migrations = artifacts.require("../client/src/contracts/Migrations.sol");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
