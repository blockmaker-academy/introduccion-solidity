const Web3 = require('web3');

// Connect to an Ethereum node
const web3 = new Web3('https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY');

// Replace 'YourContractABI' and 'YourContractAddress' with the ABI and address of the smart contract you want to interact with
const contractABI = [...]; // Your contract's ABI
const contractAddress = '0xYourContractAddress'; // Your contract's address

// Create a contract instance
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Subscribe to the event
const event = contract.events.ProductoComprado({ fromBlock: 0, toBlock: 'latest' });

// contract = Mercado
// events = ProductoAgregado ProductoComprado

// Listen for events
event.on('data', (event) => {
  console.log('Event data:', event.returnValues);
})
.on('changed', (event) => {
  console.log('Event changed:', event);
})
.on('error', (error) => {
  console.error('Error:', error);
});