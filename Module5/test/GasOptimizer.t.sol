// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/GasOptimizer.sol";

contract GasOptimizerTest is Test {
    GasOptimizer gasOptimizer;

    // Users and amounts arrays
    address[] users;
    uint256[] amounts;

    // Set up the test environment
    function setUp() public {
        // Deploy the GasOptimizer contract
        gasOptimizer = new GasOptimizer();

        // Add some example users
        users.push(address(0x1001));
        users.push(address(0x1002));
        users.push(address(0x1003));

        // Set amounts for each user
        amounts.push(1 ether);
        amounts.push(2 ether);
        amounts.push(3 ether);

        // Fund the test contract with enough ETH
        vm.deal(address(this), 6 ether);
    }

    // Test sending ETH to multiple users
    function testMultiSend() public {
        gasOptimizer.multiSend{value: 6 ether}(users, amounts);
    }

    // Test leftover refund when sent more ETH than needed
    function testRefundLeftover() public {
        // Send extra ETH
        gasOptimizer.multiSend{value: 10 ether}(users, amounts);

        // The leftover should be refunded to this contract
        assertEq(address(this).balance, 4 ether);
    }

    // Benchmark gas usage for multiSend
    function testGasUsage() public {
        gasOptimizer.multiSend{value: 6 ether}(users, amounts);
    }
}
