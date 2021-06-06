const TokenMock = artifacts.require("TokenMock");
const StateChannel = artifacts.require("StateChannel");

module.exports = async function(deployer, network, accounts) {
  await deployer.deploy(TokenMock);
  const token = await TokenMock.deployed()
  console.log(token.address)
  await deployer.deploy(StateChannel, '0x11DE92df6E662d5e718cF163C6588ebc6eF07e09', '0x3581708b29bc5Bc1cfA835522579Af3b1000C9fb', token.address );
  const stateChannel = await StateChannel.deployed();
};
