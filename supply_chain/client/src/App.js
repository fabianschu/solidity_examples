import React, { Component } from "react";
import ItemManagerContract from "./contracts/ItemManager.json";
import ItemContract from "./contracts/Item.json";
import getWeb3 from "./getWeb3";

import "./App.css";

class App extends Component {
  state = {
    storageValue: 0,
    web3: null,
    accounts: null,
    contract: null,
    cost: "",
    identifier: "",
  };

  componentDidMount = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();
      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = ItemManagerContract.networks[networkId];

      const itemManagerInstance = new web3.eth.Contract(
        ItemManagerContract.abi,
        deployedNetwork && deployedNetwork.address
      );

      const itemInstance = new web3.eth.Contract(
        ItemContract.abi,
        deployedNetwork && deployedNetwork.address
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      this.setState(
        {
          web3,
          accounts,
          contract: { itemManagerInstance, itemInstance },
          cost: "",
        },
        this.runExample
      );
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`
      );
      console.error(error);
    }
  };

  handleChange = (e) => {
    const { target } = e;
    this.setState({ ...this.state, [target.name]: target.value });
  };

  handleSubmit = async () => {
    const { cost, identifier } = this.state;

    let result = await this.state.contract.itemManagerInstance.methods
      .createItem(identifier, cost)
      .send({ from: this.state.accounts[0] });
    console.log(result);
    alert(
      "Send " +
        cost +
        " Wei to " +
        result.events.SupplyChainStep.returnValues._address
    );
    console.log(result);
  };

  render() {
    if (!this.state.web3) {
      return <div>Loading Web3, accounts, and contract...</div>;
    }

    return (
      <div className="App">
        <h1>Event Trigger / Supply Chain Example</h1>
        <h2>Items</h2>
        <h2>Add Items</h2>
        <div>
          {" "}
          <label>Cost in Wei</label>
          <input
            type="text"
            name="cost"
            value={this.state.cost}
            onChange={this.handleChange}
          />
        </div>
        <div>
          <label>Item identifier</label>
          <input
            type="text"
            name="identifier"
            value={this.state.identifier}
            onChange={this.handleChange}
          />
        </div>
        <button type="submit" onClick={this.handleSubmit}>
          create
        </button>
        <div>The stored value is: {this.state.storageValue}</div>
      </div>
    );
  }
}

export default App;
