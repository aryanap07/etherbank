# EtherBank

EtherBank is a decentralized banking smart contract built with Solidity for the Ethereum Virtual Machine (EVM). It enables users to securely deposit, withdraw, and transfer Ether while maintaining balances entirely on-chain without relying on a centralized intermediary.

## Overview

EtherBank is a lightweight banking smart contract designed for the Ethereum Virtual Machine (EVM). It allows users to securely deposit Ether into the contract, maintain individual balances, transfer balances between users, and withdraw funds at any time.

The contract follows modern Solidity development practices, including custom errors, events for transaction logging, and secure Ether transfers using `call`.

## Features

* Deposit Ether into the smart contract.
* Withdraw deposited Ether securely.
* Transfer internal balances between users.
* Query individual account balances.
* View the total Ether held by the contract.
* Event logging for deposits, withdrawals, and transfers.
* Custom errors for efficient gas usage.

## Contract

| Contract   | Description                                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------------------- |
| `Bank.sol` | Implements a decentralized banking system for managing Ether deposits, withdrawals, and internal balance transfers. |

## Functions

### `deposit()`

Deposits Ether into the contract and credits the sender's internal balance.

**Requirements**

* `msg.value` must be greater than zero.

---

### `withdraw(uint256 amount)`

Withdraws the specified amount of Ether from the sender's balance.

**Requirements**

* Amount must be greater than zero.
* Sender must have sufficient balance.

---

### `transfer(address recipient, uint256 amount)`

Transfers an internal balance from the sender to another user.

**Requirements**

* Recipient cannot be the zero address.
* Recipient cannot be the sender.
* Amount must be greater than zero.
* Sender must have sufficient balance.

---

### `balanceOf(address account)`

Returns the balance of any account stored within the contract.

---

### `myBalance()`

Returns the caller's current balance.

---

### `bankBalance()`

Returns the total Ether currently stored in the smart contract.

## Events

| Event         | Description                                       |
| ------------- | ------------------------------------------------- |
| `Deposited`   | Emitted when Ether is deposited.                  |
| `Withdrawn`   | Emitted when Ether is withdrawn.                  |
| `Transferred` | Emitted when an internal balance transfer occurs. |

## Custom Errors

| Error                   | Description                          |
| ----------------------- | ------------------------------------ |
| `ZeroAmount()`          | The provided amount is zero.         |
| `InsufficientBalance()` | The account balance is insufficient. |
| `InvalidRecipient()`    | Recipient address is invalid.        |

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
4. Compile using Solidity `0.8.20`.
5. Deploy using the Remix VM or any EVM-compatible network.

## Usage

### Deposit Ether

Call `deposit()` and send Ether with the transaction.

### Check Your Balance

Call `myBalance()`.

### Transfer Funds

Call `transfer(recipient, amount)` to move balances within the contract.

### Withdraw Ether

Call `withdraw(amount)` to transfer Ether back to your wallet.

### View Contract Balance

Call `bankBalance()`.

## Security Considerations

* Ether transfers use the recommended `call` method.
* Internal balances are validated before withdrawals and transfers.
* Invalid operations revert using custom errors.
* Solidity's built-in overflow and underflow protections are enabled.

## License

This project is licensed under the MIT License.
