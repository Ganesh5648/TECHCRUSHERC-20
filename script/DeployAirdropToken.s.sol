// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/AirdropToken.sol";

/**
 * @title DeployAirdropToken
 * @dev Script to deploy the Airdrop token contract
 */
contract DeployAirdropToken is Script {
    function run() external returns (AirdropToken) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        AirdropToken token = new AirdropToken();
        vm.stopBroadcast();
        console.log("AirdropToken deployed to:", address(token));
        console.log("Deployer address:", msg.sender);
        console.log("Total supply:", token.totalSupply());
        return token;
    }
}
