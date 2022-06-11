// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14; // this is the solidity version to be used
contract SimpleStorage{
    // Premitive types in solidity include used to define variables
    // boolean, uint, int, address, bytes
    //unassigned variable gets initialised to zero
    //for example
    // bool hasFavouriteNumber = true;
    // uint256 FavouriteNumber = 5;
    // string favouriteNumberInText = "Five";
    // int256 negativeFavouriteInt = -5; 
    // address myAddress = 0xF53C57B1012A4d6b6Eb555641aB77109F7370F20;
    // bytes32 favouriteBytes = "cat";

    uint256 favouriteNumber;
    uint256 public brothersfavouriteNumber;
    People public person = People({favouriteNumber: 2, name: "Shams"});

    struct People{
        uint256 favouriteNumber;
        string name;
    }

    People[] public people;

    function store(uint256 _favouriteNumber) public {
        favouriteNumber = _favouriteNumber;
    }

    //view and pure functions do not spend any gas
    function retrieve() public view returns(uint256){
        return favouriteNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public{
        people.push(People(_favouriteNumber, _name));
    }

}
//0xd9145CCE52D386f254917e481eB44e9943F39138