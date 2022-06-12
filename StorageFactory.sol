//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

//this storageFactory contract will allow us to create simpleStorage contracts
contract StorageFactory {

    //this function in particular is the one that creates the simpleStorage contracts
    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }
    //then created simpleStorage contracts are saved in this array
    SimpleStorage[] public simpleStorageArray;

    // then we can call different functions on the stored simpleStorage contracts
    function StorageFactoryStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //in order to interact with any contract, you need the 
        //'address' and the 'ABI - Application Binary Interface' of that contract
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    //function that reads simpleStorage contract values from the storageFactory
    function storageFactoryGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return simpleStorageArray[_simpleStorageIndex].retrieve();
    }

    //We now have a simpleStorage contractc that can store variables in a
    //storageFactory contract, which can be like a manager of the simple storage
    //contract and deploy and interact with them
}