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
    
    console.log('Set up completed');
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});