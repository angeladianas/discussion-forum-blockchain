const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface, bytecode} = require('./compile');

const provider = new HDWalletProvider(
    'drift loop width rose memory idea steel match rude involve tattoo dust',
    'https://rinkeby.infura.io/v3/287018d520ee42b8adfbb97ca4daa62b'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account,', accounts[0]);

    // previously with older version
    //const result = await new web3.eth.Contract(JSON.parse(interface))
    //    .deploy({ data: bytecode, arguments: ['Hi there!']})
    //    .send({ gas: '1000000', from: accounts[0] });

    const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({data: '0x' + bytecode}) // add 0x bytecode
    .send({from: accounts[0]}); // remove 'gas'

    console.log(interface); // can remove, this only to see interface

    console.log('Contract deployed to', result.options.address);
};
deploy();

// ADDRESS : 0x6372D125434c7324777e049429820fAd435A3D88
