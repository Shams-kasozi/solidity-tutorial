// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14; // this is the solidity version to be used

//EVM, Etherium Virtual Machine
//Avalanche, Fantom, Polygon are some other networks that we can use

contract SimpleStorage{
    //A contract is similar to a class in other languages
    // Premitive types in solidity include used to define variables
    // boolean, uint, int, address, bytes
    //unassigned variable gets initialised to zero
    //for example

    //some of the types in solidity.....
    // bool hasFavouriteNumber = true;
    // uint256 FavouriteNumber = 5;
    // string favouriteNumberInText = "Five";
    // int256 negativeFavouriteInt = -5; 
    // address myAddress = 0xF53C57B1012A4d6b6Eb555641aB77109F7370F20;
    // bytes32 favouriteBytes = "cat";

    uint256 favouriteNumber;

    //you can create dictionaries like in NoSql/relations like in SQL/mappings
    //or hash tables like this, using the 'mapping' function. which when you give
    //it a key, it will spit out the value that the key represents
    mapping(string => uint256) public nameToFavouriteNumber;

    //you can create a new type in solidity by using the 'struct' keyword
    struct People{
        uint256 favouriteNumber;
        string name;
    }
    //you can create arrays or lists in solidity like this
    People[] public people;

    function store(uint256 _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
    }

    //view and pure functions do not spend any gas
    //this is the function that does not modify the state of the contract
    function retrieve() public view returns(uint256){
        return favouriteNumber; 
    }

    //you can create functions that modify the state of the blockchain like this
    //we can also specify different data locations in our functions using keywords
    //like calldata, 'memory' and 'storage'

    //'calldata' and 'memory', mean that the data is only temporary and only exists for 
    //the duration of the function

    //'storage' variables are permanent and stay there for ever
    function addPerson(string memory _name, uint256 _favouriteNumber) public{
        people.push(People(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}
