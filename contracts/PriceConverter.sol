// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() public view returns(uint256) {
        // ABI
        // Address: 0x779877A7B0D9E8603169DdbD7836e478b4624789
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        (,int256 price,,,) = priceFeed.latestRoundData();

        //price returns value upto 8 decimal places
        //we need to make it upto 18 decimal places so we can compare it to msg.value
        return uint256(price * 1e10); // 1**10 = 10000000000
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint ethAmountInUsd = (ethPrice * ethAmount) / 10 * 1e18;

        return ethAmountInUsd;
    }
}