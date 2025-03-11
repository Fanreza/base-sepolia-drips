# BaseSepoliaFaucetContract

## Overview
The **BaseSepoliaFaucetContract** is a simple smart contract designed for the Sepolia testnet, providing a faucet mechanism that allows users to request a small amount of ETH with a cooldown period. Additionally, users can deposit ETH into the contract to fund the faucet.

### Sample Verified Contract
https://sepolia.basescan.org/address/0x11274e325a2c924a744b35aa5fefca314e4c59cd

## Features

### 1. **Request Faucet (0.001 ETH per request)**
- Users can request **0.001 ETH** from the faucet.
- Requests are subject to a **cooldown period** of **1 hour** per address.
- Ensures that the faucet balance is sufficient before sending funds.
- Emits a **FaucetRequested** event upon a successful request.

### 2. **Cooldown Mechanism**
- Prevents users from requesting ETH repeatedly within a short time.
- Uses `lastRequestTime` mapping to track the last request timestamp for each address.

### 3. **ETH Deposit Support**
- Users can **deposit ETH** into the contract to support faucet operations.
- Deposits are tracked per address in the `deposits` mapping.
- Emits a **DepositReceived** event for transparency.

### 4. **Receive ETH Functionality**
- The contract has a **receive function** to accept ETH sent directly (e.g., via MetaMask).
- Deposits received this way are also tracked.

### 5. **Check Contract Balance**
- Users can call `getContractBalance()` to check the contract’s current ETH balance.

## Events
- `FaucetRequested(address indexed requester, uint256 amount)`: Emitted when a user successfully requests ETH from the faucet.
- `DepositReceived(address indexed depositor, uint256 amount)`: Emitted when a user deposits ETH into the faucet.

## Usage
1. **Request Faucet ETH:** Call `sendFaucet(address payable _requester)`.
2. **Deposit ETH to Faucet:** Send ETH via `deposit()` or directly to the contract address.
3. **Check Faucet Balance:** Call `getContractBalance()`.

## Requirements
- Solidity **0.8.20**
- Sepolia Testnet
- ETH to fund the faucet

## License
This project is licensed under the **MIT License**.
