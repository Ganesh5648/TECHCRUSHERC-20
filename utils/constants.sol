//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library constants {
    string public constant TOKEN_NAME = "TECHCRUSHTOKEN";
    string public constant TOKEN_SYMBOL = "TCTN";
    uint8 public constant DECIMAL = 18; 

    uint256 public constant INITIAL_SUPPLY = 1_000_000 * 10**DECIMALS;  // 1 million tokens
    uint256 public constant MAX_SUPPLY = 10_000_000 * 10**DECIMALS;     // 10 Million tokens 

    uint256 public constant AIRDROP_AMOUNT = 100*10**DECIMALS;   // 100 tokens per airdrop
    uint256 public constant MAX_AIRDROP_RECIPIENTS = 1000;      // Maximum number of airdrop recipients

    uint256 public constant VESTING_PERIOD = 365 days;         // 1 year vesting
    uint256 public constant LOCK_PERIOD = 30 days;            // 30ndays lock period 

    uint256 public constant BURN_FEE_PERCENT = 200;          // 2% burn fee
    uint256 public constant TRANSFER_FEE_PERCENT = 100;     // 1% Transfer fee

    bytes public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    
}