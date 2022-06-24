//imports
const { ethers, run, network} = require("hardhat")

//async main
async function main() {
  //the code to deploy our contract
  const SimpleStorageFactory = await ethers.getContractFactory(
    "SimpleStorage"
  )
  console.log("Deploying contarct...")
  const simpleStorage = await SimpleStorageFactory.deploy()
  await simpleStorage.deployed()
  console.log(`deployed contract to: ${simpleStorage.address}`)

  //if we are on a testnet like rinkeby, this code verifies our contract
  if (network.config.chainId === 4 && process.env.ETHERSCAN_API_KEY) {
    await simpleStorage.deployTransaction.wait(6)
    await verify(simpleStorage.address, [])
  }
  
  //checks for the innital value of our favourite number
  const currentValue = await simpleStorage.retrieve()
  console.log(`Current value is: ${currentValue}`)

  //update the current value of our favourite number
  const transactionResponse = await simpleStorage.store(7)
  await transactionResponse.wait(1)
  const updatedValue = await simpleStorage.retrieve()
  console.log(`Updated value is: ${updatedValue}`)
}

async function verify(contractAddress, args) {
  console.log("Verifying contract...")
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: args,
    })
  }catch(error){
    if (error.message.toLowerCase().includes("already verified")){
      console.log("Already verified!")
    }else {
      console.log(error)
    }
  } 
}

//main
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1 )
  })