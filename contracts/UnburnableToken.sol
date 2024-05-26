// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UnburnableToken {
    mapping(address => uint256) public balances;
    uint256 public totalSupply;
    uint256 public totalClaimed;
    mapping(address => bool) private claimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    constructor() {
        totalSupply = 100000000;
    }

    function claim() public {
        // Check if all tokens have been claimed
        if (totalClaimed >= totalSupply) revert AllTokensClaimed();
        // Check if the caller has already claimed tokens
        if (claimed[msg.sender]) revert TokensClaimed();

        // Update balances and claimed status
        balances[msg.sender] += 1000;
        totalClaimed += 1000;
        claimed[msg.sender] = true;
    }

    function safeTransfer(address _to, uint256 _amount) public {
        // Unsafe transfer conditions
        if (_to == address(0) || _to.balance == 0) revert UnsafeTransfer(_to);
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Perform the transfer
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
