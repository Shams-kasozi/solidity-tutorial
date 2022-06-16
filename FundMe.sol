//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error notOwner();

contract FundMe {

    using PriceConverter for uint256;

    //the constant keyword will make the MINIMUM_USD variable more gas efficient
    uint256 public constant MINIMUM_USD = 50 * 1e18; //1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    //using the immutable and constant keywords to make our contract more gas efficient
    address public immutable i_owner;

    //then we create a constructor where we assign the 'owner' variable to the sender
    constructor() {
        i_owner = msg.sender;
    }

    //our funding method is now complete
    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough ETH"); 
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
        require(msg.sender == i_owner, "Sender is not the owner!");

        //we can use an 'if' statement with a 'revert' keyword instead of the 'require' keyword 
        //for more efficiency
        if(msg.sender != i_owner){ revert notOwner();}
        _;
    }
}