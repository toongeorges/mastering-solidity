const { ethers } = require("hardhat");

async function main() {
    [deployer] = await ethers.getSigners();

    //mint 1500 of our own cryptocurrency
    console.log('Deploying our SEED cryptocurrency');
    const SeedToken = await ethers.getContractFactory("SeedToken");
    const seedToken = await SeedToken.deploy(
        deployer.address,
        "Seed Token",
        "SEED"
    );
    await seedToken.waitForDeployment();
    const currencyAddress = await seedToken.getAddress();

    console.log(`Our cryptocurrency address is ${currencyAddress}`);
    console.log('Minting 1500 tokens');
    let response = await seedToken.mint(1500);
    await response.wait();

    //set up our MetaMask addresses
    console.log('Retrieving MetaMask addresses');
    const phrase = 'elegant swallow slide budget eye state '
                 + 'middle talent piece possible someone lady';

    const mnemonic = ethers.Mnemonic.fromPhrase(phrase);

    const accounts = [];
    for (let i = 0; i < 5; i++) {
        accounts.push(ethers.HDNodeWallet.fromMnemonic(
            mnemonic,
            `m/44'/60'/0'/0/${i}` //See BIP 44
        ));
    }

    //transfer (test) Ethers and our cryptocurrency to MetaMask
    const decimals = await seedToken.decimals();
    const multiplier = 10n ** decimals;
    for (let i = 0; i < 5; i++) {
        const account = accounts[i];
        const etherAmount = 120/(i + 1);
        const cryptoAmount = (i + 1)*100;
        console.log(
            'Transferring %i ETH and %i SEED to %s',
            etherAmount,
            cryptoAmount,
            account.address
        );

        await deployer.sendTransaction({
            from: deployer.address,
            to: account.address,
            value: ethers.parseEther(`${etherAmount}`),
            //explicit gasLimit to have multiple transactions in 1 block
            gasLimit: 21000
        });

        response = await seedToken.transfer(
            account.address,
            BigInt(cryptoAmount)*multiplier, {
                //explicit gasLimit to have multiple transactions in 1 block
                gasLimit: 60000
            }
        );
    }
    await response.wait();
    
    console.log('Set up completed');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});