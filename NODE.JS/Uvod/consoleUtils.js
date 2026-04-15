const readline = require('readline');
const util = require('util')
 
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});
 
const input = util.promisify(rl.question).bind(rl)
const print = rl.write.bind(rl);
 const close = rl.close.bind(rl);
 
 module.exports.input = input;
 module.exports.print = print;
 module.exports.close = close;