const ItemManager = artifacts.require("./ItemManager.sol");

contract("ItemManager", (accounts) => {
  it("...should be possible to add an item.", async () => {
    const itemManagerInstance = await ItemManager.deployed();
    const itemName = "test1";
    const itemPrice = 500;

    const result = await itemManagerInstance.createItem(itemName, itemPrice, {
      from: accounts[0],
    });
    assert.equal(result.logs[0].args._itemIndex, 0, "It's not the first error");

    const item = await itemManagerInstance.items(0);
    assert.equal(item._identifier, itemName, "The identifier was different");
    // // Set value of 89
    // await simpleStorageInstance.set(89, { from: accounts[0] });

    // // Get stored value
    // const storedData = await simpleStorageInstance.get.call();

    // assert.equal(storedData, 89, "The value 89 was not stored.");
  });
});
