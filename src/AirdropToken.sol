// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AirdropToken is ERC20, Ownable{

    address private _deployer;

    mapping (address => bool) private _hasClaimedAirdrop;

    uint256 public constant MAX_BATCH_SIZE = 50;

    event AirdropExecuted(
        address indexed executor,
        uint256 recipientCount,
        uint256 totalAmount,
        uint256 timestamp
    );

    event AirdropClaimed(
        address indexed recipient,
        uint256 amount,
        uint256 timestamp
    );
    
    constructor() Ownable(msg.sender)
    ERC20("TECHCRUSHTOKEN", "TCTN"){
        _deployer = msg.sender; 
        _mint(msg.sender, 1000000 * (10**18));
    }

    function airdrop(
        address[] memory recipients,
        uint256[] memory amounts
    ) external onlyOwner{
        require (recipients.length > 0, "Recipients length is empty");
        require (amounts.length > 0, "Amount arrays is empty");

        require (recipients.length == amounts.length,
        "Recipients and amount length mismatch");

        require (
            recipients.length <= MAX_BATCH_SIZE,
            "Batch size exceeds maximum limits"
        );

        uint256 totalAmount = 0;

        for (uint256 i = 0; i < recipients.length; i++){
            address recipient = recipients[i];
            uint256 amount = amounts[i];

            require (recipient != address(0), "Cannot airdrop to zero address");

            require (amount > 0, "Cannot airdrop zero tokens");

            require (
                !_hasClaimedAirdrop[recipient] ,
                "Address has already claimed airdrop"
            );

                // Mark as claimed
                _hasClaimedAirdrop[recipient] = true;

                // Transfer token
                _transfer(msg.sender, recipient, amount);

                //Add to total
                totalAmount += amount;

                //Emit event for this recipient 
                emit AirdropClaimed(recipient, amount, block.timestamp);
        
        }

        // Emit batch event
        emit AirdropExecuted(
            msg.sender,
            recipients.length,
            totalAmount,
            block.timestamp
        );
    }

    function hasClaimedAirdrop(address account) public view returns(bool) {
        return _hasClaimedAirdrop[account];
    }

    function deployer() public view returns(address) {
        return _deployer;
    }

}
