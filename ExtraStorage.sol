//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./SimpleStorage.sol";
//we want our extra storage contract to add 5 to any number that we give it
// we ca achive this by overiding fucntions
//there 2 keywards to be used i.e. virtual and overide
contract ExtraStorage is SimpleStorage {
    //implementing a store function for extra storage
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}