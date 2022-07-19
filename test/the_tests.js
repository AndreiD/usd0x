const { expect } = require("chai")
const { web3, ethers } = require("hardhat")

let USD0x
let owner, acc1, acc2, acc3

describe("Simple Tests", function () {
	beforeEach(async function () {
		let TContract = await ethers.getContractFactory("USD0x")
		USD0x = await TContract.deploy()
		await USD0x.deployed()

		signers = await ethers.getSigners()
		owner = signers[0]
		acc1 = signers[1]
		acc2 = signers[2]
		acc3 = signers[3]

		const minterHash = web3.utils.soliditySha3("MINTER_ROLE")
		console.log("minterHash ", minterHash)
	})

	it("simple tests", async function () {
		console.log("owner = ", owner.address)
		console.log("acc1 = ", acc1.address)
		console.log("acc2 = ", acc2.address)
		console.log("acc3 = ", acc3.address)
		expect(await USD0x.totalSupply()).to.equal("1000000000000000000000")
	})
})
