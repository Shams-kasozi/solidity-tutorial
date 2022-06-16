const ethers = require("ethers");
const fs = require("fs-extra")

async function main(){
    //http:0.0.0.0:8545
    const provider = new ethers.providers.JsonRpcProvider("http://127.0.0.1:7545")
    const wallet = new ethers.Wallet("35232f8eb09946c6e8625aa53ff25af67d31cc0af2d82a3e1797e2e345f66263", provider)
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8")
    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
    console.log("Deploying, Please wait...")
    const contract = await contractFactory.deploy();//STOP and wait for the contract to deploy
    console.log(contract)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
})