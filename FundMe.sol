//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./AggregatorV3Interface.sol";//this is an interface gotten from https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
//we need to get funds from users
//withdraw finds
//set a minimum funding value in USD

contract FundMe {

    uint256 public minimumUsd = 50;

    function fund() public payable{
        //1. How do we send ETH to this contract?
        //we use 'msg.value' to set the value of how much someone has to send
        require(msg.value >= minimumUsd, "Didn't send enough ETH"); 
        //1e18 == 1 * 10^18 == 1000000000000000000, thats 1 with 18 zeros
    }

    function getPrice() public view returns(uint256){
        //ABI
        //Address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //ETH in terms of USD
        //3000,00000000
        return uint256(price * 1e10); //1**10 == 10000000000
    }

    function getVersion() public view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
    // function withdraw(){}
}