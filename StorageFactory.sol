//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

contract StorageFactory {
    //keeping track of all our deployed contracts
    //we make SimpleStorage an array
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function StorageFactoryStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        //in order to interact with any contract, you need the 
        //'address' and the 'ABI - Application Binary Interface' of that contract
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        simpleStorage.store(_simpleStorageNumber);
    }

    //function that reads from the simpleStorage contract to the storageFactory
    function storageFactoryGet(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }

}