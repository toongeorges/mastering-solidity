const { expect } = require("chai");

describe("SeedToken Test", function () {
    const mnemonic = 'wood zebra throw venture possible ugly pencil story hurry worry minute panel';
    const wallet = new ethers.Wallet(ethers.Wallet.fromPhrase(mnemonic).privateKey, ethers.provider);
    const mnemonic2 = 'music goose pitch observe cradle double water budget swim crew water canyon';
    const wallet2 = new ethers.Wallet(ethers.Wallet.fromPhrase(mnemonic2).privateKey, ethers.provider);
    let deployer;
    let seedToken;

    before(async function() {
        [deployer] = await ethers.getSigners();

        //make sure the wallets have enough ethers to execute a transation
        await deployer.sendTransaction({
            from: deployer.address,
            to: wallet.address,
            value: ethers.parseEther("100")
        });
        await deployer.sendTransaction({
            from: deployer.address,
            to: wallet2.address,
            value: ethers.parseEther("100")
        });
    });

    beforeEach(async function() {
        const SeedToken = await ethers.getContractFactory("SeedToken");
        seedToken = await SeedToken.deploy(deployer.address, "Seed Token", "SEED");
    });

    it("sets the original owner correctly", async function () {
        const originalOwner = await seedToken.owner();

        expect(originalOwner).to.equal(deployer.address);
    });
    it("allows the owner to set a new owner", async function () {
        await seedToken.changeOwner(wallet.address);
        const newOwner = await seedToken.owner();

        expect(newOwner).to.equal(wallet.address);
    });
    it("does not allow anyone else to set a new owner", async function () {
        let isExceptionThrown = false;
        try {
            await seedToken.connect(wallet).changeOwner(wallet.address);
        } catch (e) { //expected
            isExceptionThrown = true;
        }
    
        expect(isExceptionThrown, "exception to be thrown on changing the owner").to.be.true;
    });
    it("allows the owner to mint tokens", async function () {
        const decimals = await seedToken.decimals();
        const divisor = 10n ** decimals;
        let originalAmount = await seedToken.totalSupply();
        originalAmount = originalAmount / divisor;

        await seedToken.changeOwner(wallet.address);
        await seedToken.connect(wallet).mint(12345);

        let mintedAmount = await seedToken.totalSupply();
        mintedAmount = mintedAmount / divisor;

        expect(originalAmount).to.equal(0);
        expect(mintedAmount).to.equal(12345);
    });
    it("does not allow anyone else to mint tokens", async function () {
        await seedToken.changeOwner(wallet.address);

        let isExceptionThrown = false;
        try {
            await seedToken.connect(wallet2).mint(67890);
        } catch (e) { //expected
            isExceptionThrown = true;
        }
    
        expect(isExceptionThrown, "exception to be thrown on minting tokens").to.be.true;
    });
});
