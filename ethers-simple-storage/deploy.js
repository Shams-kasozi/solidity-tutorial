const ethers = require("ethers");
const fs = require("fs-extra")

async function main(){
    //http:0.0.0.0:8545
    const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545")
    const wallet = new ethers.Wallet("5f742921a1c4fc56c30f48b5fe3611fa981906dba4ea6f2a2a7deaa26066b6a8", provider)
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8")

    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
    console.log("Deploying, Please wait...")
    const contract = await contractFactory.deploy();//STOP and wait for the contract to deploy
    await contract.deployTransaction.wait(1)

    //Interacting with contracts. i.e. calling the methods on our contract SimpleStorage
    //getting the favourite number
    const currentFavouriteNumber = await contract.retrieve()
    console.log(`Current favourite Number is: ${currentFavouriteNumber.toString()}`)
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
})