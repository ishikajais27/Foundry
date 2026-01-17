// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Greeting.sol";   // adjust path if needed

contract GreetingTest is Test {
    Greeting greetContract;

    function setUp() public {
        // Deploy with an initial greeting
        greetContract = new Greeting("Hello");
    }

    function testInitialGreeting() public {
        // Check the initial greet value
        assertEq(greetContract.readGreet(), "Hello");
    }

    function testUpdateGreeting() public {
        // Update greeting
        greetContract.updateGreet("Namaste");

        // Check updated value
        assertEq(greetContract.readGreet(), "Namaste");
    }
}
