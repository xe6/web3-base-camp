// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "hardhat/console.sol";

interface ILock {
    event Created(address owner, uint amount);
}

contract Lock is ILock {
    uint public unlockTime;
    address payable public owner;

    event Withdrawal(uint amount, uint when);

    constructor(uint _unlockTime) payable {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        owner = payable(msg.sender);
        emit Created(msg.sender, msg.value);
    }

    function withdraw() public {
        console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        owner.transfer(address(this).balance);
    }
}
