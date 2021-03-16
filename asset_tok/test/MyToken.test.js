const MyToken = artifacts.require("MyToken");

var chai = require("chai");
const BN = web3.utils.BN;
const chaiBN = require("chai-bn")(BN);
chai.use(chaiBN);

var chaiAsPromised = require("chai-as-promised");
chai.use(chaiAsPromised);

const expect = chai.expect;

contract("MyToken", (accounts) => {
  it("should place all tokens in my account", async () => {
    let instance = await MyToken.deployed();
    let totalSupply = await instance.totalSupply();
    expect(await instance.balanceOf(accounts[0])).to.be.a.bignumber.equal(
      totalSupply
    );
  });
});
