// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/AirdropToken.sol";

/**
 * @title DeployAirdropToken
 * @dev Script to deploy the AirdropToken contract
 */
contract DeployAirdropToken is Script {
    function run() external returns (AirdropToken) {
        // Read private key from environment variable
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);
        
        // Deploy the contract
        AirdropToken token = new AirdropToken();
        
        // Stop broadcasting
        vm.stopBroadcast();
        
        // Log deployment info
        console.log("AirdropToken deployed to:", address(token));
        console.log("Deployer address:", msg.sender);
        console.log("Total supply:", token.totalSupply());
        
        return token;
    }
}