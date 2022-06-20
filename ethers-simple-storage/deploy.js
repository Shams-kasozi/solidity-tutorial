const ethers = require("ethers");
const fs = require("fs-extra")
require('dotenv').config()

async function main(){
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL)
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider)

    //changing the way we access our private key
    // const encryptedJson = fs.readFileSync("./encryptedKey.json", "utf8")
    // let wallet = new ethers.Wallet.fromEncryptedJsonSync(
    //     encryptedJson,
    //     process.env.PRIVATE_KEY_PASSWORD
    //     )
    // wallet = await wallet.connect(provider)
    const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8")
    const binary = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.bin", "utf8")

    const contractFactory = new ethers.ContractFactory(abi, binary, wallet)
    console.log("Deploying, Please wait...")
    const contract = await contractFactory.deploy();//STOP and wait for the contract to deploy
    await contract.deployTransaction.wait(1)
    console.log(`Contract address is: ${contract.address}`)

    //Interacting with contracts. i.e. calling the methods on our contract SimpleStorage
    //getting the favourite number
    const currentFavouriteNumber = await contract.retrieve()
    console.log(`Current favourite Number is: ${currentFavouriteNumber.toString()}`)

    //calling the store method on our contract to store a number
    //when you call a function/method on a contract, you get a transaction response
    const transactionResponse = await contract.store("7")
    //when you wait for the transaction to finish, you get a transaction receipt
    const transactionReceipt = await transactionResponse.wait(1)

    const updatedFavoriteNumber = await contract.retrieve()
    console.log(`Updated favorite number is: ${updatedFavoriteNumber}`)
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
})