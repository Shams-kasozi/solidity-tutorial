//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18; //1 * 10 ** 18

    address[] public funders;

    mapping(address => uint256) public addressToAmountFunded;

    //our funding method is now complete
    function fund() public payable{
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    //we will have to reset our funders array in our addressToAmountFunded to zero,
    //since we are going to withdraw all the funds to carry out activities
    //using a for loop
    function withdraw() public {
        /* starting index, still available indexes, step amount*/
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            //code
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // now we reset the array with funders to zero elements
        funders = new address[](0);
        //now we do the actual withdraw of the funds

        //there are 3 ways to send or transfer funds 
        //i.e. transfer, send and call

        //the example below elaborates the 'transfer' method and how it can be used
        //the drawback of this 'transfer' method is that it's capped at 2300gas, so it 
        //throws an error and revert the transaction when you exceed that limit

        //to transfer the funds to whoever ran the withdraw function, we do this
        payable(msg.sender).transfer(address(this).balance);//balance is the native 
        // blockchain currency balance or etherium currency balance of this address
        //msg.sender is of type 'address'
        //while as payable(msg.sender) is of type payable address

        //the example below elaborates the 'send' method and how it can be used
        //this method is also capped at 2300gas but it wont throw an error when
        //exceed the limit, instead it will return a boolean of whether or not it was
        //successful
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //if the above fails, i.e. 'sendSuccess'then "Sending failed" will be returned
        require(sendSuccess, "Sending failed");

        //the example below elaborates the 'call' method and how it can be used
        //this is one of the first lower level commands used in solidity and it's
        //incredibly powerful and can be used to call any function in all of etherium 
        //without even having to have the ABI
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

}