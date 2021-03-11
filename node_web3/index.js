import Web3 from "web3";
import abi from "./abi.js";

let web3 = new Web3(new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"));
const walletAddress1 = "0x028fB735E6754182b0D4203fcA4cB2Ee1c75Ec52";
const walletAddress2 = "0x26EDC76a52248FA88FAC8B72ca91e13D00F09F60";
const contractAddress = "0x3274485D2BaF977a2285782c23a15eDB5e1E18DD";

const getBalance = async (address) => {
  const balance = await web3.eth.getBalance(address);

  return await web3.utils.fromWei(balance, "ether");
};
// getBalance(walletAddress1).then(console.log);

const sendFromTo = async (from, to) => {
  return await web3.eth.sendTransaction({
    from,
    to,
    value: web3.utils.toWei("1", "ether"),
  });
};
// sendFromTo(walletAddress1, walletAddress2).then(console.log);

/*
  how to get function signature = data parameter of previous function
*/
const getFunctionSignature = (functionName) => {
  const hash = web3.utils.sha3(functionName);
  return hash.substr(0, 10);
};
// getFunctionSignature("myUint()").then(console.log);

/*
  from: account address
  to: contract address
  data: on remix this is the field called input to be found in the receipt of a transacion
*/
const transaction = async (from, to, data) => {
  return await web3.eth.call({ from, to, data });
};

// transaction(
//   walletAddress1,
//   contractAddress,
//   getFunctionSignature("myUint()")
// ).then(console.log);

/*
  use ABI to interact with contract
*/
let contract = new web3.eth.Contract(abi, contractAddress);

// reading from the contract
// contract.methods.myUint().call().then(console.log);

// sending data to the contract
contract.methods.setUint(40).send({ from: walletAddress1 }).then(console.log);

// console.log(contract.methods.myUint());
