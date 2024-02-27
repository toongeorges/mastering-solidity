require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.20",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000
      }
    }
  },
  networks: {
    hardhat: {
      mining: {
        auto: true,
        interval: [11000, 13000]
      }
    }
  }
};

extendEnvironment((hre) => {
  const { Web3 } = require("web3");
  const { Web3Context } = require("web3-core");

  hre.Web3 = Web3;
  hre.Web3Context = Web3Context;

  // hre.network.provider is an EIP1193-compatible provider.
  hre.web3 = new Web3(hre.network.provider);
  hre.web3Context = new Web3Context({
    provider: hre.network.provider,
    config: {
      contractDataInputFill: 'data'
    } // all new contracts created to populate 'data' field
  });
});