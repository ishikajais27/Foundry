// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasOptimizer {
    // Send ETH to multiple users efficiently
    function multiSend(address[] calldata users, uint256[] calldata amounts) external payable {
        uint userCount = users.length;
        require(userCount == amounts.length, "Array length mismatch");

        for (uint i = 0; i < userCount; ) {
            (bool sent, ) = users[i].call{value: amounts[i]}("");
            require(sent, "Transfer failed");
            unchecked { i++; } // save gas
        }

        // Refund leftover ETH
        uint leftover = address(this).balance;
        if (leftover > 0) {
            (bool refunded, ) = msg.sender.call{value: leftover}("");
            require(refunded, "Refund failed");
        }
    }
}
