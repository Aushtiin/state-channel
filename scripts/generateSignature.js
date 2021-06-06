require('dotenv').config()
const web3 = require('web3');
const stateChannel = require('../build/contracts/StateChannel.json')
const user = process.env.USER_1;
const user2 = process.env.USER_2;
// console.log(user)
const Web3 = new web3(new web3.providers.HttpProvider(process.env.PROVIDER_URL));
Web3.eth.accounts.wallet.add({
  privateKey: process.env.PK_1,
  address: user
})
const StateChannel = new Web3.eth.Contract(stateChannel.abi, process.env.STATE_CHANNEL_ADDRESS)

  const run = (async () => {
    let abi = Web3.utils.soliditySha3(
      { t: 'address', v: user },
      { t: 'uint256', v: 100 },
      { t: 'address', v: user2 },
      { t: 'uint256', v: 20 }
    )
    const sig = Web3.eth.accounts.wallet[user].sign(abi).signature
    console.log(sig);
  //   const user1 = await StateChannel.methods.execute(sig, user, user2, 100, 20).send({from: user, gas: 100000})
  //   console.log(user1)
  })()