const { expect } = require("chai");

const abi = require('../artifacts/contracts/SeedToken.sol/SeedToken.json').abi;
const bytecode = require('../artifacts/contracts/SeedToken.sol/SeedToken.json').bytecode;

describe("SeedToken Test", function () {
    const mnemonic = 'wood zebra throw venture possible ugly pencil story hurry worry minute panel';
    const wallet = new ethers.Wallet(ethers.Wallet.fromPhrase(mnemonic).privateKey, ethers.provider);
    const mnemonic2 = 'music goose pitch observe cradle double water budget swim crew water canyon';
    const wallet2 = new ethers.Wallet(ethers.Wallet.fromPhrase(mnemonic2).privateKey, ethers.provider);

    //web3.js does not provide support for mnemonics!
    const wallet_ = web3.eth.accounts.privateKeyToAccount(
        '0xd8689f37d9c31c143b2c5f8a53ef166adf9f8f9db3d41d4205efa44f9264e2c2'
    );
    const wallet2_ = web3.eth.accounts.privateKeyToAccount(
        '0x02165b45f7653cd5cd4d5d474b4469920a312aca1f0ea5b909cd8a5e27f6eb47' 
    );

    let deployer;
    let deployer_;

    let seedToken;
    let seedToken_;

    before(async function() {
        [deployer] = await ethers.getSigners();
        [deployer_] = await web3.eth.getAccounts();

        //make sure the wallets have enough ethers to execute a transation
        await deployer.sendTransaction({
            from: deployer.address,
            to: wallet.address,
            value: ethers.parseEther("100")
        });
        await web3.eth.sendTransaction({
            from: deployer_,
            to: wallet_.address,
            value: web3.utils.toWei('100', 'ether')
        });

        await deployer.sendTransaction({
            from: deployer.address,
            to: wallet2.address,
            value: ethers.parseEther("100")
        });
        await web3.eth.sendTransaction({
            from: deployer_,
            to: wallet2_.address,
            value: web3.utils.toWei('100', 'ether')
        });
    });

    beforeEach(async function() {
        const SeedToken = await ethers.getContractFactory("SeedToken");
        const SeedToken_ = new web3.eth.Contract(abi);

        seedToken = await SeedToken.deploy(deployer.address, "Seed Token", "SEED");
        const deployment = SeedToken_.deploy({
            data: bytecode,
            arguments: [deployer_, "Seed Token", "SEED"]
        });

        await seedToken.waitForDeployment();
        const receipt = await deployment.send({
            from: deployer_
        });
        seedToken_ = new web3.eth.Contract(
            abi,
            receipt.options.address,
            web3Context
        );
    });

    it("sets the original owner correctly", async function () {
        const originalOwner = await seedToken.owner();
        const originalOwner_ = await seedToken_.methods.owner().call();

        expect(originalOwner).to.equal(deployer.address);
        expect(originalOwner_).to.equal(deployer_);
    });
    it("allows the owner to set a new owner", async function () {
        const response = await seedToken.changeOwner(wallet.address);
        await response.wait();
        await seedToken_.methods.changeOwner(wallet_.address).send({
            from: deployer_
        });

        const newOwner = await seedToken.owner();
        const newOwner_ = await seedToken_.methods.owner().call();

        expect(newOwner).to.equal(wallet.address);
        expect(newOwner_).to.equal(wallet_.address);
    });
    it("does not allow anyone else to set a new owner", async function () {
        let isExceptionThrown = false;
        let isExceptionThrown_ = false;

        try {
            await seedToken.connect(wallet).changeOwner(wallet.address);
        } catch (e) { //expected
            isExceptionThrown = true;
        }
        try {
            const tx = {
                from: wallet_.address,
                to: seedToken_._address,
                gas: 1000000,
                gasPrice: 10000000000,
                data: seedToken_.methods.changeOwner(wallet_.address).encodeABI()
            }
            const signedTx = await web3.eth.accounts.signTransaction(tx, wallet_.privateKey);
            await web3.eth.sendSignedTransaction(signedTx.rawTransaction);
        } catch (e) { //expected
            isExceptionThrown_ = true;
        }
    
        expect(isExceptionThrown, "exception to be thrown on changing the owner").to.be.true;
        expect(isExceptionThrown_, "exception to be thrown on changing the owner").to.be.true;
    });
    it("allows the owner to mint tokens", async function () {
        const decimals = await seedToken.decimals();
        const decimals_ = await seedToken_.methods.decimals().call();

        const divisor = 10n ** decimals;
        const divisor_ = 10n ** decimals_;

        const originalAmount =
            await seedToken.totalSupply() / divisor;
        const originalAmount_ = 
            await seedToken_.methods.totalSupply().call() / divisor_;

        const response = await seedToken.changeOwner(wallet.address);
        await response.wait();
        await seedToken_.methods.changeOwner(wallet_.address).send({
            from: deployer_
        });

        const response2 = await seedToken.connect(wallet).mint(12345);
        await response2.wait();
        const tx = {
            from: wallet_.address,
            to: seedToken_._address,
            gas: 1000000,
            gasPrice: 10000000000,
            data: seedToken_.methods.mint(12345).encodeABI()
        }
        const signedTx = await web3.eth.accounts.signTransaction(tx, wallet_.privateKey);
        await web3.eth.sendSignedTransaction(signedTx.rawTransaction);

        const mintedAmount =
            await seedToken.totalSupply() / divisor;
        const mintedAmount_ =
            await seedToken_.methods.totalSupply().call() / divisor_;

        expect(originalAmount).to.equal(0);
        expect(originalAmount_).to.equal(0);

        expect(mintedAmount).to.equal(12345);
        expect(mintedAmount_).to.equal(12345);
    });
    it("does not allow anyone else to mint tokens", async function () {
        const response = await seedToken.changeOwner(wallet.address);
        await response.wait();
        await seedToken_.methods.changeOwner(wallet_.address).send({
            from: deployer_
        });

        let isExceptionThrown = false;
        let isExceptionThrown_ = false;

        try {
            await seedToken.connect(wallet2).mint(67890);
        } catch (e) { //expected
            isExceptionThrown = true;
        }

        try {
            const tx2 = {
                from: wallet2_.address,
                to: seedToken_._address,
                gas: 1000000,
                gasPrice: 10000000000,
                data: seedToken_.methods.mint(67890).encodeABI()
            }
            const signedTx2 = await web3.eth.accounts.signTransaction(tx2, wallet2_.privateKey);
            await web3.eth.sendSignedTransaction(signedTx2.rawTransaction);
        } catch (e) { //expected
            isExceptionThrown_ = true;
        }
        
        expect(isExceptionThrown, "exception to be thrown on minting tokens").to.be.true;
        expect(isExceptionThrown_, "exception to be thrown on minting tokens").to.be.true;
    });
});
