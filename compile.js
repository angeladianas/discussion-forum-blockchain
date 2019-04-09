const path = require('path');
const solc = require('solc'); // solidity compiler
const fs = require('fs-extra'); //file system

const discussionPath = path.resolve(__dirname, 'contracts', 'discussion.sol'); 

const source = fs.readFileSync(discussionPath, 'UTF-8'); //utf8 is a type of encoding for Inboc.sol

module.exports = solc.compile(source,1).contracts[':Discussion'];

// to see result: console.log(module.exports);