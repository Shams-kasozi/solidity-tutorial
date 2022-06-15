//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18; //1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    //to avoid anyone withdrawing our funds, we r gonna a 'modifier' where only 
    //the owner can withdraw the funds from our account using this global variable called 'owner'
    address public owner;

    //then we create a constructor where we assign the 'owner' variable to the sender
    constructor() {
        owner = msg.sender;
    }

    //our funding method is now complete
    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public OnlyOwner {
        
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            //code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // now we reset the array with funders to zero elements
        funders = new address[](0);

        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    //this 'modifier' will tell the 'withdraw' function to run this code first
    modifier OnlyOwner {
        require(msg.sender == owner, "Sender is not the owner!");
        _;
    }
}