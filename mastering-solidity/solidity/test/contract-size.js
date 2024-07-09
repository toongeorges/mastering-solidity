const { expect } = require("chai");

const maxContractSize = 24*1024;

describe("Compiled Smart Contracts Size Test", function () {
    it("Should deploy the SeedToken contract", async function () {
        const SeedToken = await ethers.getContractFactory("SeedToken");
        [deployer] = await ethers.getSigners();
        const seedToken = await SeedToken.deploy(deployer.address, "Seed Token", "SEED");
        await seedToken.waitForDeployment();
        const deployedAddress = await seedToken.getAddress();
        expect(deployedAddress).to.exist;
        const deployedCode = await seedToken.getDeployedCode();
        //- 2 to remove the leading 0x, /2 because 2 hexadecimal ciphers = 1 byte
        const size = (deployedCode.length - 2)/2;
        console.log('    SeedToken contract size: ' + size + ' bytes');
        expect(size <= maxContractSize).to.be.true;
    });
});