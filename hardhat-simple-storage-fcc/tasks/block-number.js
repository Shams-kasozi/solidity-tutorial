//we will use this to get the current block number of 
//whatever block we are working with

const {task} = require("hardhat/config")

task("block-number", "Prints the current block number")
.setAction(
    async(taskArgs, hre) => { //'hre' stands for Hardhat Runtime Environment
        const blockNumber = await hre.ethers.provider.getBlockNumber()
        console.log(`Current block number is: ${blockNumber}`)
    }
)