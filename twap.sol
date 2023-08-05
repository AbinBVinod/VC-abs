// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TWAPOracle {
    address public strategy;
    uint256 public lastExecutionTime;
    uint256 public lastCumulativePrice;
    
    constructor(address _strategy) {
        strategy = _strategy;
        lastExecutionTime = block.timestamp;
        lastCumulativePrice = 1 ether; // Initial price
    }
    
    modifier onlyStrategy() {
        require(msg.sender == strategy, "Only strategy can call this");
        _;
    }
    
    function updatePrice(uint256 cumulativePrice) external onlyStrategy {
        uint256 elapsedTime = block.timestamp - lastExecutionTime;
        uint256 priceChange = cumulativePrice - lastCumulativePrice;
        uint256 averagePrice = (priceChange * 1 ether) / elapsedTime;
        
       
        
        lastExecutionTime = block.timestamp;
        lastCumulativePrice = cumulativePrice;
        
        emit PriceUpdated(averagePrice);
    }
    
    event PriceUpdated(uint256 averagePrice);
}
