# EtherBank

A secure Ethereum smart contract that enables users to deposit, withdraw, and transfer Ether entirely on-chain. Built with Solidity, EtherBank demonstrates the fundamentals of decentralized banking through a lightweight, transparent, and efficient smart contract implementation.

## Overview

EtherBank is a lightweight banking smart contract designed for the Ethereum Virtual Machine (EVM). It allows users to securely deposit Ether, maintain individual on-chain balances, transfer balances between accounts within the contract, and withdraw their funds at any time.

The contract follows modern Solidity best practices, including custom errors for gas efficiency, event logging for transparency, secure Ether transfers using `call`, and the Checks-Effects-Interactions (CEI) pattern to reduce reentrancy risk.

## Features

* Deposit Ether into the smart contract.
* Withdraw deposited Ether securely.
* Transfer internal balances between users.
* Query the balance of any account.
* View your own account balance.
* View the total Ether held by the contract.
* Event logging for deposits, withdrawals, and transfers.
* Custom errors for efficient and gas-optimized error handling.

## Contract

| Contract   | Description                                                                                                                 |
| ---------- | --------------------------------------------------------------------------------------------------------------------------- |
| `Bank.sol` | Implements a decentralized banking smart contract for managing Ether deposits, withdrawals, and internal balance transfers. |

## Functions

### `deposit()`

Deposits Ether into the smart contract and credits the sender's internal balance.

**Requirements**

* `msg.value` must be greater than zero.

---

### `withdraw(uint256 amount)`

Withdraws the specified amount of Ether from the caller's internal balance.

**Requirements**

* `amount` must be greater than zero.
* The caller must have sufficient balance.

---

### `transfer(address recipient, uint256 amount)`

Transfers an internal balance from the caller to another account within the contract.

**Requirements**

* Recipient cannot be the zero address.
* Recipient cannot be the caller.
* `amount` must be greater than zero.
* The caller must have sufficient balance.

---

### `balanceOf(address account)`

Returns the balance associated with any account stored within the contract.

---

### `myBalance()`

Returns the caller's current balance.

---

### `bankBalance()`

Returns the total amount of Ether currently held by the smart contract.

## Events

| Event         | Description                                            |
| ------------- | ------------------------------------------------------ |
| `Deposited`   | Emitted whenever Ether is deposited into the contract. |
| `Withdrawn`   | Emitted whenever Ether is withdrawn from the contract. |
| `Transferred` | Emitted whenever an internal balance transfer occurs.  |

## Custom Errors

| Error                   | Description                                                         |
| ----------------------- | ------------------------------------------------------------------- |
| `ZeroAmount()`          | The provided amount is zero.                                        |
| `InsufficientBalance()` | The account does not have enough balance to complete the operation. |
| `InvalidRecipient()`    | The recipient address is invalid.                                   |

## Project Structure

```text
EtherBank/
├── Bank.sol
├── README.md
└── LICENSE
```

## Deployment

1. Open Remix IDE.
2. Create a new Solidity file named `Bank.sol`.
3. Paste the contract source code.
4. Compile using Solidity **0.8.20** or later.
5. Deploy using the Remix VM or any EVM-compatible network.

## Usage

### Deposit Ether

Call `deposit()` and send Ether with the transaction.

### Check Your Balance

Call `myBalance()`.

### Check Another Account's Balance

Call `balanceOf(account)`.

### Transfer Funds

Call `transfer(recipient, amount)` to move balances between users inside the contract.

### Withdraw Ether

Call `withdraw(amount)` to transfer Ether back to your wallet.

### View Contract Balance

Call `bankBalance()` to view the total Ether currently stored in the smart contract.

## Security Considerations

* Follows the Checks-Effects-Interactions (CEI) pattern before external calls.
* Ether transfers use the recommended low-level `call` method.
* Internal balances are validated before withdrawals and transfers.
* Invalid operations revert using gas-efficient custom errors.
* Solidity 0.8.x provides built-in overflow and underflow protection, with `unchecked` used only where prior validation guarantees safe arithmetic.
* Deposits must be made through the `deposit()` function; the contract does not implement `receive()` or `fallback()` functions for direct Ether transfers.

## Limitations

* Supports Ether only (no ERC-20 tokens).
* Does not provide interest, lending, or staking functionality.
* Does not include administrative or governance features.
* Intended as an educational demonstration of Ethereum smart contract development.

## License

This project is licensed under the MIT License.
