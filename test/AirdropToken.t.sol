// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AirdropToken.sol";

contract AirdropTokenTest is Test {
    AirdropToken public token;
    address public owner;
    address public user1;
    address public user2;
    address public user3;
    address public user4;
    address public user5;
    
    // Events to test
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
    
    function setUp() public {
        // This runs before each test
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);
        user3 = address(0x3);
        user4 = address(0x4);
        user5 = address(0x5);
        
        // Deploy the token
        token = new AirdropToken();
    }
    
    // Test 1: Check deployment state
    function test_Deployment() public {
        assertEq(token.name(), "TECHCRUSHTOKEN");
        assertEq(token.symbol(), "TCTN");
        assertEq(token.decimals(), 18);
        assertEq(token.totalSupply(), 1000000 * 10**18);
        assertEq(token.balanceOf(owner), 1000000 * 10**18);
        assertEq(token.owner(), owner);
    }
    
    // Test 2: Successful airdrop to single address
    function test_AirdropSingleRecipient() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        amounts[0] = 1000 * 10**18;
        
        token.airdrop(recipients, amounts);
        
        assertEq(token.balanceOf(user1), 1000 * 10**18);
        assertTrue(token.hasClaimedAirdrop(user1));
    }
    
    // Test 3: Successful airdrop to multiple addresses (5 addresses)
    function test_AirdropMultipleRecipients() public {
        address[] memory recipients = new address[](5);
        uint256[] memory amounts = new uint256[](5);
        
        recipients[0] = user1;
        recipients[1] = user2;
        recipients[2] = user3;
        recipients[3] = user4;
        recipients[4] = user5;
        
        amounts[0] = 1000 * 10**18;
        amounts[1] = 2000 * 10**18;
        amounts[2] = 1500 * 10**18;
        amounts[3] = 3000 * 10**18;
        amounts[4] = 2500 * 10**18;
        
        uint256 ownerBalanceBefore = token.balanceOf(owner);
        uint256 totalAirdrop = 10000 * 10**18;
        
        token.airdrop(recipients, amounts);
        
        // Check all recipients received tokens
        assertEq(token.balanceOf(user1), 1000 * 10**18);
        assertEq(token.balanceOf(user2), 2000 * 10**18);
        assertEq(token.balanceOf(user3), 1500 * 10**18);
        assertEq(token.balanceOf(user4), 3000 * 10**18);
        assertEq(token.balanceOf(user5), 2500 * 10**18);
        
        // Check owner balance decreased
        assertEq(token.balanceOf(owner), ownerBalanceBefore - totalAirdrop);
        
        // Check all marked as claimed
        assertTrue(token.hasClaimedAirdrop(user1));
        assertTrue(token.hasClaimedAirdrop(user2));
        assertTrue(token.hasClaimedAirdrop(user3));
        assertTrue(token.hasClaimedAirdrop(user4));
        assertTrue(token.hasClaimedAirdrop(user5));
    }
    
    // Test 4: Prevent double claim
    function test_RevertWhen_DoubleClaim() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        amounts[0] = 1000 * 10**18;
        
        // First airdrop succeeds
        token.airdrop(recipients, amounts);
        
        // Second airdrop to same address should fail
        vm.expectRevert("Address has already claimed airdrop");
        token.airdrop(recipients, amounts);
    }
    
    // Test 5: Only owner can airdrop
    function test_RevertWhen_NonOwnerTriesAirdrop() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        amounts[0] = 1000 * 10**18;
        
        // Try to airdrop from non-owner account
        vm.prank(user1);
        vm.expectRevert();
        token.airdrop(recipients, amounts);
    }
    
    // Test 6: Revert when recipients array is empty
    function test_RevertWhen_EmptyRecipientsArray() public {
        address[] memory recipients = new address[](0);
        uint256[] memory amounts = new uint256[](0);
        
        vm.expectRevert("Recipients length is empty");
        token.airdrop(recipients, amounts);
    }
    
    // Test 7: Revert when arrays length mismatch
    function test_RevertWhen_ArrayLengthMismatch() public {
        address[] memory recipients = new address[](2);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        recipients[1] = user2;
        amounts[0] = 1000 * 10**18;
        
        vm.expectRevert("Recipients and amount length mismatch");
        token.airdrop(recipients, amounts);
    }
    
    // Test 8: Revert when exceeding batch size
    function test_RevertWhen_ExceedingBatchSize() public {
        address[] memory recipients = new address[](51);
        uint256[] memory amounts = new uint256[](51);
        
        for (uint256 i = 0; i < 51; i++) {
            recipients[i] = address(uint160(i + 1));
            amounts[i] = 1000 * 10**18;
        }
        
        vm.expectRevert("Batch size exceeds maximum limits");
        token.airdrop(recipients, amounts);
    }
    
    // Test 9: Revert when airdropping to zero address
    function test_RevertWhen_AirdropToZeroAddress() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = address(0);
        amounts[0] = 1000 * 10**18;
        
        vm.expectRevert("Cannot airdrop to zero address");
        token.airdrop(recipients, amounts);
    }
    
    // Test 10: Revert when airdropping zero tokens
    function test_RevertWhen_AirdropZeroTokens() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        amounts[0] = 0;
        
        vm.expectRevert("Cannot airdrop zero tokens");
        token.airdrop(recipients, amounts);
    }
    
    // Test 11: Check events are emitted correctly
    function test_EmitsAirdropClaimedEvent() public {
        address[] memory recipients = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        
        recipients[0] = user1;
        amounts[0] = 1000 * 10**18;
        
        vm.expectEmit(true, false, false, true);
        emit AirdropClaimed(user1, 1000 * 10**18, block.timestamp);
        
        token.airdrop(recipients, amounts);
    }
    
    // Test 12: Check AirdropExecuted event
    function test_EmitsAirdropExecutedEvent() public {
        address[] memory recipients = new address[](2);
        uint256[] memory amounts = new uint256[](2);
        
        recipients[0] = user1;
        recipients[1] = user2;
        amounts[0] = 1000 * 10**18;
        amounts[1] = 2000 * 10**18;
        
        vm.expectEmit(true, false, false, true);
        emit AirdropExecuted(owner, 2, 3000 * 10**18, block.timestamp);
        
        token.airdrop(recipients, amounts);
    }
    
    // Test 13: Max batch size (50 addresses)
    function test_AirdropMaxBatchSize() public {
        address[] memory recipients = new address[](50);
        uint256[] memory amounts = new uint256[](50);
        
        for (uint256 i = 0; i < 50; i++) {
            recipients[i] = address(uint160(i + 1));
            amounts[i] = 100 * 10**18;
        }
        
        token.airdrop(recipients, amounts);
        
        // Verify first and last recipient
        assertEq(token.balanceOf(recipients[0]), 100 * 10**18);
        assertEq(token.balanceOf(recipients[49]), 100 * 10**18);
    }
    
    // Test 14: Standard ERC20 transfer still works
    function test_StandardTransfer() public {
        uint256 amount = 5000 * 10**18;
        token.transfer(user1, amount);
        
        assertEq(token.balanceOf(user1), amount);
        assertEq(token.balanceOf(owner), 1000000 * 10**18 - amount);
    }
}