const { ethers } = require("hardhat")
const {expect, assert} = require("chai")

//testing our simple storage code locally
describe("SimpleStorage", function () {
  let SimpleStorageFactory, simpleStorage
  beforeEach(async function () {
    SimpleStorageFactory = await ethers.getContractFactory("SimpleStorage")
    simpleStorage = await SimpleStorageFactory.deploy()
  })

  it("Should start with a favorite number of 0", async function () {
    const currentValue = await simpleStorage.retrieve()
    const expectedValue = "0"
    //to confirm the output with 'chai', we can use the 'assert' or 'expect' keywords
    assert.equal(currentValue.toString(), expectedValue)
  })
  it("Should update when we call store", async function (){
    const expectedValue = "7"
    const transactionResponse = await simpleStorage.store(expectedValue)
    await transactionResponse.wait(1)

    const currentValue = await simpleStorage.retrieve()
    //using 'assert' keyword
    assert.equal(currentValue.toString(), expectedValue)

    //using 'expect' keyword
    // expect(currentValue.toString()).to.equal(expectedValue)
  })
})