# Architecture

## Overview

EtherBank is a decentralized banking smart contract designed for the Ethereum Virtual Machine (EVM). The contract enables users to deposit Ether, maintain internal account balances, transfer balances between users, and securely withdraw their funds.

The architecture follows a simple state-based design where all user balances are maintained within the smart contract while the contract itself acts as the custodian of deposited Ether.

---

# High-Level Architecture

```text
                    Ethereum Blockchain
                             │
                             │
                     User Transaction
                             │
                             ▼
                    ┌─────────────────┐
                    │  Bank Contract  │
                    ├─────────────────┤
                    │                 │
                    │  balances       │
                    │  Events         │
                    │  Validation     │
                    │                 │
                    └─────────────────┘
                       │     │      │
          ┌────────────┘     │      └────────────┐
          │                  │                   │
          ▼                  ▼                   ▼
      Deposit()         Transfer()         Withdraw()
          │                  │                   │
          ▼                  ▼                   ▼
   Update Balance     Move Internal      Send Ether
                      Account Balance      to User
```

---

# Contract Components

## State Storage

```solidity
mapping(address => uint256) private balances;
```

The contract stores each user's deposited Ether using a mapping where:

* Key → Ethereum account address
* Value → User balance in wei

Each address has an independent internal balance maintained by the contract.

---

## Events

The contract emits events whenever an important state transition occurs.

| Event       | Purpose                            |
| ----------- | ---------------------------------- |
| Deposited   | Records successful deposits        |
| Withdrawn   | Records successful withdrawals     |
| Transferred | Records internal balance transfers |

These events provide an immutable transaction history that can be indexed by blockchain explorers and decentralized applications.

---

## Custom Errors

Instead of revert strings, the contract uses custom errors.

| Error               | Purpose                                |
| ------------------- | -------------------------------------- |
| ZeroAmount          | Prevents zero-value transactions       |
| InsufficientBalance | Prevents overdrawing balances          |
| InvalidRecipient    | Prevents invalid transfer destinations |

Custom errors reduce deployment size and transaction gas costs.

---

# Functional Architecture

## Deposit Flow

```text
User
 │
 │ Sends Ether
 ▼
deposit()
 │
 │ Validate msg.value
 ▼
Increase User Balance
 │
 ▼
Emit Deposited Event
```

The deposited Ether becomes part of the smart contract's total balance while simultaneously increasing the sender's internal account balance.

---

## Withdrawal Flow

```text
User
 │
 │ Requests Withdrawal
 ▼
withdraw(amount)
 │
 │ Validate Balance
 ▼
Reduce User Balance
 │
 ▼
Transfer Ether
 │
 ▼
Emit Withdrawn Event
```

Withdrawals follow the Checks-Effects-Interactions pattern by updating the internal state before transferring Ether.

---

## Internal Transfer Flow

```text
Sender
 │
 ▼
transfer(recipient, amount)
 │
 │ Validate Recipient
 │ Validate Amount
 │ Validate Balance
 ▼
Subtract Sender Balance
 │
 ▼
Add Recipient Balance
 │
 ▼
Emit Transferred Event
```

Internal transfers only modify the accounting records inside the contract.

No Ether leaves the smart contract during this operation.

---

# Balance Model

EtherBank maintains two independent balance concepts.

## Internal Account Balance

Each user owns an internal balance stored within the contract.

```text
Alice → 5 ETH
Bob   → 3 ETH
Carol → 2 ETH
```

These balances are maintained using the `balances` mapping.

---

## Contract Balance

The smart contract itself owns all deposited Ether.

```text
Contract Balance

5 ETH
+3 ETH
+2 ETH
────────
10 ETH
```

The total contract balance always equals the sum of all user balances.

---

# Security Design

The contract incorporates several security mechanisms.

## Input Validation

Every externally accessible function validates its inputs before modifying the contract state.

---

## Balance Verification

Withdrawals and transfers require sufficient user balance before execution.

---

## Secure Ether Transfer

Ether is transferred using the low-level `call` function.

```solidity
(bool success, ) = payable(msg.sender).call{value: amount}("");
```

This approach is compatible with current Solidity best practices.

---

## Checks-Effects-Interactions

The withdrawal logic updates contract state before interacting with external addresses.

This minimizes risks associated with reentrancy attacks.

---

## Event Logging

Every successful state-changing operation emits an event.

This provides transparent and verifiable transaction history.

---

# Data Flow

```text
                User Wallet
                     │
                     │
             Ethereum Transaction
                     │
                     ▼
              Bank Smart Contract
                     │
      ┌──────────────┼──────────────┐
      │              │              │
      ▼              ▼              ▼
  Deposit       Transfer      Withdraw
      │              │              │
      ▼              ▼              ▼
 balances[]     balances[]     balances[]
      │              │              │
      └──────────────┼──────────────┘
                     │
                     ▼
             Contract Storage
```

---

# Design Principles

* Minimal contract architecture
* Deterministic state transitions
* Gas-efficient custom errors
* Event-driven transaction logging
* Secure Ether transfer mechanism
* Clear separation between internal accounting and contract funds
* Modern Solidity development practices
