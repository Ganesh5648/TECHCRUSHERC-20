# TECHCRUSHTOKEN (TCTN) - ERC-20 Token with Airdrop Functionality

![Solidity](https://img.shields.io/badge/Solidity-0.8.13-363636?style=flat-square&logo=solidity)
![Foundry](https://img.shields.io/badge/Foundry-Latest-blue?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Tests](https://img.shields.io/badge/Tests-14%2F14%20Passing-success?style=flat-square)

A production-ready ERC-20 token smart contract with built-in batch airdrop functionality, comprehensive testing, and detailed tokenomics documentation.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contract Addresses](#contract-addresses)
- [Documentation](#documentation)
- [Security](#security)
- [License](#license)

---

## 🎯 Project Overview

TECHCRUSHTOKEN (TCTN) is a custom ERC-20 token featuring efficient batch airdrop capabilities for community distribution. The project demonstrates professional smart contract development practices including comprehensive testing, gas optimization, and thorough documentation.

**Key Statistics:**
- Total Supply: 1,000,000 TCTN
- Decimals: 18
- Max Batch Size: 50 addresses per transaction
- Test Coverage: 100% (14/14 tests passing)
- Airdrop Recipients: 10 addresses (15,000 TCTN distributed)

---

## ✨ Features

### Core Functionality
- ✅ **ERC-20 Standard Compliant** - All required functions (transfer, approve, transferFrom, balanceOf, etc.)
- ✅ **Batch Airdrop System** - Distribute tokens to multiple addresses in a single transaction
- ✅ **Duplicate Claim Prevention** - Each address can only claim once via mapping tracker
- ✅ **Access Control** - Owner-only airdrop execution using OpenZeppelin's Ownable
- ✅ **Event Tracking** - Comprehensive event emissions (Transfer, AirdropClaimed, AirdropExecuted)

### Security Features
- 🔒 Zero address validation
- 🔒 Array length matching verification
- 🔒 Batch size limits (MAX_BATCH_SIZE = 50)
- 🔒 Zero amount rejection
- 🔒 Built-in overflow protection (Solidity 0.8.x)
- 🔒 Duplicate claim prevention mapping

---

## 🛠️ Technology Stack

- **Solidity**: ^0.8.13 (Smart contract development)
- **Foundry**: Development framework, testing, and deployment
- **OpenZeppelin**: Battle-tested smart contract libraries (ERC20, Ownable)
- **Anvil**: Local blockchain for development and testing
- **Cast**: Command-line tool for blockchain interactions
- **Forge**: Testing and building framework

---

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
  ```bash
  curl -L https://foundry.paradigm.xyz | bash
  foundryup
  ```
- Git for version control
- MetaMask or similar wallet for testing
- Node.js (optional, for additional tooling)

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/techcrush-token.git
cd techcrush-token
```

2. **Install dependencies:**
```bash
forge install
```

3. **Set up environment variables:**
```bash
cp .env.example .env
# Edit .env with your values
```

Example `.env`:
```env
# Network Configuration
ANVIL_RPC_URL=http://127.0.0.1:8545
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_API_KEY

# Deployment
PRIVATE_KEY=your_private_key_here

# Optional: For Etherscan verification
ETHERSCAN_API_KEY=your_etherscan_api_key
```

⚠️ **Security Warning**: Never commit your `.env` file or expose private keys!

4. **Compile contracts:**
```bash
forge build
```

5. **Run tests:**
```bash
forge test
```

---

## 📁 Project Structure

```
TECHCRUSHERC-20/
│
├── src/                          # Smart contract source files
│   └── AirdropToken.sol         # Main ERC20 token with airdrop functionality
│
├── script/                       # Deployment and interaction scripts
│   └── DeployAirdropToken.s.sol # Main deployment script
│
├── test/                         # Test files
│   └── AirdropToken.t.sol       # Comprehensive test suite (14 tests)
│
├── broadcast/                    # Foundry deployment tracking (auto-generated)
│   └── DeployAirdropToken.s.sol/
│       ├── 31337/               # Localhost (Anvil) deployments
│       │   └── run-latest.json  # Latest local deployment details
│       ├── 11155111/            # Sepolia testnet deployments
│       └── 1/                   # Mainnet deployments (future)
│
├── docs/                         # Project documentation
│   ├── TOKEN_ECONOMICS.md       # Token distribution and economics
│   ├── AIRDROP_GUIDE.md         # Airdrop execution instructions (optional)
│   └── API_REFERENCE.md         # Contract function documentation (optional)
│
├── lib/                          # Foundry dependencies
│   ├── forge-std/               # Forge standard library
│   └── openzeppelin-contracts/  # OpenZeppelin contracts
│
├── out/                          # Compiled contract artifacts (auto-generated)
├── cache/                        # Foundry cache (auto-generated)
│
├── .env                          # Environment variables (NEVER commit!)
├── .env.example                 # Template for environment variables
├── .gitignore                   # Git ignore rules
├── foundry.toml                 # Foundry configuration
└── README.md                    # This file
```

### Key Folders Explained

#### `src/` - Smart Contracts
Contains all Solidity smart contracts.
- **AirdropToken.sol**: Main ERC20 token with batch airdrop functionality
- Built using OpenZeppelin's ERC20 and Ownable base contracts

#### `script/` - Deployment Scripts
Deployment scripts written in Solidity for type safety.
- Execute with: `forge script script/DeployAirdropToken.s.sol --broadcast`
- Foundry uses Solidity scripts instead of JavaScript

#### `test/` - Test Suite
Comprehensive tests written in Solidity using Foundry's testing framework.
- Pattern: `*.t.sol`
- Run with: `forge test`
- 14 tests covering deployment, airdrop functionality, access control, and edge cases

#### `broadcast/` - Deployment History
**Automatically generated** by Foundry during deployments.
- Organized by script name and chain ID
- Contains addresses, transaction hashes, gas usage, timestamps
- `run-latest.json`: Most recent deployment
- Historical deployments saved as `run-{timestamp}.json`

#### `docs/` - Documentation
Comprehensive project documentation:
- **TOKEN_ECONOMICS.md**: Detailed tokenomics (supply, distribution, vesting)
- Additional guides for users and developers

#### `lib/` - Dependencies
Foundry packages installed via `forge install`.
- Similar to `node_modules` in npm projects
- Never edit directly; managed by Foundry

---

## 🔄 Development Workflow

### 1. Start Local Blockchain

Start Anvil (Foundry's local Ethereum node):
```bash
anvil
```

This provides:
- 10 pre-funded accounts with 10,000 ETH each
- Local blockchain at `http://127.0.0.1:8545`
- Instant block mining
- Chain ID: 31337

### 2. Deploy Contracts

**Deploy to Anvil (local):**
```bash
forge script script/DeployAirdropToken.s.sol:DeployAirdropToken \
  --rpc-url http://127.0.0.1:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --broadcast
```

**Deploy to Sepolia testnet:**
```bash
forge script script/DeployAirdropToken.s.sol:DeployAirdropToken \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verify \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

### 3. Interact with Contract

**Check token balance:**
```bash
cast call <CONTRACT_ADDRESS> \
  "balanceOf(address)(uint256)" \
  <YOUR_ADDRESS> \
  --rpc-url http://127.0.0.1:8545
```

**Execute airdrop (owner only):**
```bash
cast send <CONTRACT_ADDRESS> \
  "airdrop(address[],uint256[])" \
  "[0xAddress1,0xAddress2,0xAddress3]" \
  "[1000000000000000000000,2000000000000000000000,3000000000000000000000]" \
  --rpc-url http://127.0.0.1:8545 \
  --private-key <OWNER_PRIVATE_KEY>
```

**Check if address claimed airdrop:**
```bash
cast call <CONTRACT_ADDRESS> \
  "hasClaimedAirdrop(address)(bool)" \
  <ADDRESS_TO_CHECK> \
  --rpc-url http://127.0.0.1:8545
```

### 4. Find Deployment Information

After deploying, your contract address is in:
```bash
broadcast/DeployAirdropToken.s.sol/{CHAIN_ID}/run-latest.json
```

Quick command to extract contract address:
```bash
cat broadcast/DeployAirdropToken.s.sol/31337/run-latest.json | jq -r '.transactions[0].contractAddress'
```

---

## 🧪 Testing

The project includes a comprehensive test suite with 14 tests covering all functionality.

### Run All Tests

```bash
forge test
```

### Run with Verbosity Levels

```bash
forge test -v      # Show test names
forge test -vv     # Show test names + logs
forge test -vvv    # Show test names + logs + traces
forge test -vvvv   # Show everything including setup
```

### Run Specific Test

```bash
forge test --match-test test_AirdropMultipleRecipients -vvv
```

### Generate Gas Report

```bash
forge test --gas-report
```

### Check Code Coverage

```bash
forge coverage
```

### Test Results Summary

```
Running 14 tests for test/AirdropToken.t.sol:AirdropTokenTest

[PASS] test_Deployment() (gas: 32,496)
[PASS] test_AirdropSingleRecipient() (gas: 74,314)
[PASS] test_AirdropMultipleRecipients() (gas: 308,387)
[PASS] test_AirdropMaxBatchSize() (gas: 2,578,154)
[PASS] test_RevertWhen_DoubleClaim() (gas: 78,288)
[PASS] test_RevertWhen_NonOwnerTriesAirdrop() (gas: 17,178)
[PASS] test_RevertWhen_EmptyRecipientsArray() (gas: 13,264)
[PASS] test_RevertWhen_ArrayLengthMismatch() (gas: 19,680)
[PASS] test_RevertWhen_ExceedingBatchSize() (gas: 88,986)
[PASS] test_RevertWhen_AirdropToZeroAddress() (gas: 14,931)
[PASS] test_RevertWhen_AirdropZeroTokens() (gas: 17,042)
[PASS] test_EmitsAirdropClaimedEvent() (gas: 75,778)
[PASS] test_EmitsAirdropExecutedEvent() (gas: 131,358)
[PASS] test_StandardTransfer() (gas: 44,501)

Test result: ok. 14 passed; 0 failed; 0 skipped
```

### Test Coverage Areas

- ✅ Deployment and initialization
- ✅ Single and batch airdrop functionality
- ✅ Access control (owner-only functions)
- ✅ Duplicate claim prevention
- ✅ Input validation (zero addresses, array mismatches)
- ✅ Batch size limits
- ✅ Event emissions
- ✅ Standard ERC20 operations

---

## 🌐 Deployment

### Pre-Deployment Checklist

Before deploying to any network:

- [ ] All tests passing (`forge test`)
- [ ] Gas estimates reviewed (`forge test --gas-report`)
- [ ] Environment variables configured
- [ ] Token economics finalized
- [ ] Deployment script tested on local network
- [ ] For testnet: Faucet ETH obtained
- [ ] For mainnet: Security audit completed
- [ ] Multi-sig wallet set up (if applicable)

### Getting Testnet ETH

For Sepolia testnet deployment:
- [Alchemy Sepolia Faucet](https://sepoliafaucet.com/)
- [Infura Sepolia Faucet](https://www.infura.io/faucet/sepolia)
- [Sepolia PoW Faucet](https://sepolia-faucet.pk910.de/)

### Deployment Steps

1. **Deploy the contract:**
```bash
forge script script/DeployAirdropToken.s.sol:DeployAirdropToken \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```

2. **Verify on Etherscan:**
```bash
forge verify-contract <CONTRACT_ADDRESS> \
  src/AirdropToken.sol:AirdropToken \
  --chain sepolia \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

3. **Update README with contract address**

4. **Execute initial airdrop** (if applicable)

---

## 📍 Contract Addresses

### Anvil (Local Testnet)
```
Network:          Anvil Local (Chain ID: 31337)
Contract Address: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Owner Address:    0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Block Number:     2
Deployment Gas:   1,753,822
Status:           ✅ Active
```

**Airdrop Activity:**
- Batch 1: 5 addresses - 10,000 TCTN distributed
- Batch 2: 5 addresses - 5,000 TCTN distributed
- Total: 10 addresses - 15,000 TCTN distributed

### Sepolia Testnet
```
Network:          Sepolia (Chain ID: 11155111)
Contract Address: [To be deployed]
Owner Address:    [Your address]
Etherscan:        [Link to be added]
Status:           ⏳ Pending deployment
```

### Mainnet
```
Status:           Not deployed
⚠️ Caution:      Requires security audit before mainnet deployment
```

---

## ⚡ Gas Usage Report

| Function | Gas Cost | Notes |
|----------|----------|-------|
| Deploy Contract | 1,753,822 | One-time deployment cost |
| Single Airdrop (1 addr) | 74,314 | Minimal overhead |
| Batch Airdrop (5 addrs) | 308,387 | ~61k gas per address |
| Batch Airdrop (50 addrs) | 2,578,154 | ~51k gas per address (optimized) |
| Standard Transfer | 44,501 | ERC20 transfer |
| Check Claimed Status | ~2,500 | View function (no gas on read) |

**Gas Optimization Techniques Used:**
- Efficient loop structures
- Minimal storage writes
- Batch processing to amortize costs
- OpenZeppelin's gas-optimized ERC20

---

## 📚 Documentation

Detailed documentation is available in the `docs/` folder:

### Core Documentation
- **[Token Economics](docs/TOKEN_ECONOMICS.md)** - Complete tokenomics breakdown
  - Supply distribution (50% airdrop, 30% team, 15% liquidity, 5% reserve)
  - Airdrop tiers and allocation strategy
  - Use cases and utility roadmap
  - Security features and auditing status

### Smart Contract Functions

#### ERC-20 Standard Functions
```solidity
function transfer(address to, uint256 amount) external returns (bool)
function approve(address spender, uint256 amount) external returns (bool)
function transferFrom(address from, address to, uint256 amount) external returns (bool)
function balanceOf(address account) external view returns (uint256)
function totalSupply() external view returns (uint256)
function allowance(address owner, address spender) external view returns (uint256)
```

#### Custom Airdrop Functions
```solidity
// Execute batch airdrop (owner only)
function airdrop(address[] memory recipients, uint256[] memory amounts) external onlyOwner

// Check if address has claimed
function hasClaimedAirdrop(address account) public view returns (bool)

// View deployer address
function deployer() public view returns (address)

// Maximum batch size constant
uint256 public constant MAX_BATCH_SIZE = 50
```

---

## 🔒 Security

### Security Features Implemented
- ✅ OpenZeppelin's audited ERC20 and Ownable implementations
- ✅ Solidity 0.8.x built-in overflow/underflow protection
- ✅ Comprehensive input validation
- ✅ Access control on sensitive functions
- ✅ Duplicate claim prevention
- ✅ Batch size limits to prevent DoS
- ✅ Zero address rejection
- ✅ 100% test coverage

### Audit Status
- ✅ Comprehensive test suite (14 tests)
- ✅ Using battle-tested OpenZeppelin contracts
- ⏳ Third-party security audit: Pending

### Known Considerations
- Owner has centralized control (consider multi-sig for production)
- No emergency pause mechanism (can be added if needed)
- No token burning functionality (can be added if needed)

### Security Best Practices

1. **Private Key Management**
   - Never commit private keys to version control
   - Use hardware wallets for production deployments
   - Consider multi-signature wallets for mainnet

2. **Testing Before Deployment**
   - Run full test suite: `forge test`
   - Test on Anvil first
   - Deploy to testnet before mainnet
   - Verify contract behavior matches expectations

3. **Deployment Security**
   - Double-check deployment parameters
   - Verify contract on Etherscan immediately
   - Test basic functions post-deployment
   - Monitor contract activity

### Reporting Security Issues

If you discover a security vulnerability:
- **DO NOT** create a public GitHub issue
- Email: security@yourproject.com (replace with actual email)
- Include detailed description and reproduction steps

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch:**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Write tests for new functionality**
4. **Ensure all tests pass:**
   ```bash
   forge test
   ```
5. **Update documentation as needed**
6. **Commit your changes:**
   ```bash
   git commit -m 'Add amazing feature'
   ```
7. **Push to the branch:**
   ```bash
   git push origin feature/amazing-feature
   ```
8. **Open a Pull Request**

### Development Guidelines
- Follow Solidity style guide
- Write comprehensive tests
- Document complex logic
- Keep gas costs reasonable
- Update README for significant changes

---

## 📖 Resources

### Official Documentation
- [Foundry Book](https://book.getfoundry.sh/) - Foundry framework documentation
- [OpenZeppelin Docs](https://docs.openzeppelin.com/) - Smart contract library
- [Solidity Docs](https://docs.soliditylang.org/) - Solidity language reference
- [ERC-20 Standard](https://eips.ethereum.org/EIPS/eip-20) - Token standard specification

### Learning Resources
- [Foundry Tutorial](https://github.com/smartcontractkit/foundry-starter-kit) - Getting started guide
- [Smart Contract Security](https://consensys.github.io/smart-contract-best-practices/) - Security best practices
- [Gas Optimization](https://github.com/iskdrews/awesome-solidity-gas-optimization) - Gas optimization techniques

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 TECHCRUSHTOKEN

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

## 🙏 Acknowledgments

- [OpenZeppelin](https://openzeppelin.com/) - Secure smart contract library
- [Foundry](https://getfoundry.sh/) - Blazing fast Ethereum development framework
- [Ethereum Foundation](https://ethereum.org/) - For the Ethereum platform
- Community contributors and testers

---

## 📞 Contact & Support

- **GitHub Issues**: [Report bugs or request features](https://github.com/yourusername/techcrush-token/issues)
- **Email**: your.email@example.com
- **Documentation**: [Full documentation](https://docs.yourproject.com)

---

## 🗺️ Roadmap

### ✅ Phase 1: Foundation (Completed)
- [x] ERC-20 token implementation
- [x] Airdrop functionality with batch processing
- [x] Comprehensive test suite (14 tests)
- [x] Local deployment on Anvil
- [x] MetaMask integration
- [x] Token economics documentation

### 🚧 Phase 2: Testnet (In Progress)
- [ ] Deploy to Sepolia testnet
- [ ] Etherscan contract verification
- [ ] Community testing phase
- [ ] Bug fixes and optimizations
- [ ] Additional airdrop rounds

### 📋 Phase 3: Advanced Features (Planned)
- [ ] Vesting schedule implementation
- [ ] Multi-signature ownership
- [ ] Token burning mechanism
- [ ] Staking functionality
- [ ] Governance module

### 🎯 Phase 4: Production (Future)
- [ ] Professional security audit
- [ ] Mainnet deployment preparation
- [ ] DEX listing
- [ ] Community governance activation

---

**Built with ❤️ using Foundry and Solidity**

*Last Updated: October 27, 2025*