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

    //we can wait on block to make sure it gets attached to the chain
    //can be termed as a transaction receipt
    const transactionReceipt = await contract.deployTransaction.wait(1)
        console.log("Here is the deployment transaction:")
        console.log(contract.deployTransaction)
        console.log("Here is the transaction receipt:")
    console.log(transactionReceipt)
    console.log(contract)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
})