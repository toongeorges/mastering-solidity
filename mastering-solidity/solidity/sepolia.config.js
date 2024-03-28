require("@nomicfoundation/hardhat-toolbox");
const { infuraApiKey, accountPrivateKey } = require("./infura.json");

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
    sepolia: {
        url: `https://sepolia.infura.io/v3/${infuraApiKey}`,
        accounts: [accountPrivateKey]
      }
  }
};
