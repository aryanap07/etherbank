// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {
    mapping(address => uint256) private balances;

    event Deposited(address indexed account, uint256 amount);
    event Withdrawn(address indexed account, uint256 amount);
    event Transferred(address indexed from, address indexed to, uint256 amount);

    error ZeroAmount();
    error InsufficientBalance();
    error InvalidRecipient();

    function deposit() external payable {
        if (msg.value == 0) revert ZeroAmount();

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) external {
        if (amount == 0) revert ZeroAmount();

        uint256 balance = balances[msg.sender];

        if (balance < amount) revert InsufficientBalance();

        unchecked {
            balances[msg.sender] = balance - amount;
        }

        (bool success, ) = payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) external {
        if (recipient == address(0) || recipient == msg.sender) {
            revert InvalidRecipient();
        }

        if (amount == 0) revert ZeroAmount();

        uint256 balance = balances[msg.sender];

        if (balance < amount) revert InsufficientBalance();

        unchecked {
            balances[msg.sender] = balance - amount;
        }

        balances[recipient] += amount;

        emit Transferred(msg.sender, recipient, amount);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function myBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function bankBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
