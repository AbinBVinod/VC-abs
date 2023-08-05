// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VaultManager {
    address public user;
    address public vaultManager;
    uint256 public maxTradeAmount;

    constructor(address _user, address _vaultManager, uint256 _maxTradeAmount) {
        user = _user;
        vaultManager = _vaultManager;
        maxTradeAmount = _maxTradeAmount;
    }

    modifier onlyUser() {
        require(msg.sender == user, "Only user can call this");
        _;
    }

    modifier onlyVaultManager() {
        require(msg.sender == vaultManager, "Only vault manager can call this");
        _;
    }

    function setMaxTradeAmount(uint256 _amount) external onlyUser {
        maxTradeAmount = _amount;
    }

    function trade(address amm, address tokenIn, address tokenOut, uint256 amount) external onlyVaultManager {    // Perform the trade using the specified AMM and strategy
        require(amount <= maxTradeAmount, "Trade amount exceeds max limit");
        
        
        //function interacts with the chosen AMM
        
        emit TradeExecuted(amm, tokenIn, tokenOut, amount);
    }

    event TradeExecuted(address indexed amm, address indexed tokenIn, address indexed tokenOut, uint256 amount);
}
