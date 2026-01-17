// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Greeting {
    string public greet;

    // Constructor to set initial greeting
    constructor(string memory _greet) {
        greet = _greet;
    }

    // Function to read the greeting
    function readGreet() public view returns (string memory) {
        return greet;
    }

    // Function to update the greeting
    function updateGreet(string memory _newGreet) public {
        greet = _newGreet;
    }

    /*
    NFC Comments:

    1. D:
       - Run a local blockchain on your machine for testing.
       - Example: `anvil` starts a personal blockchain with fake accounts and fast mining.
       - Helps test contracts without using real ETH.

    2. Cast:
       - Command line tool to interact with deployed contracts.
       - Read contract data: `cast call <contract> "readGreet()(string)"`
       - Write/update contract: `cast send <contract> "updateGreet(string)" "Hi" --private-key <key>`
       - Works without deploying scripts; fast for testing.

    3. Chisel:
       - Interactive REPL for Solidity.
       - Lets you write and test functions line by line.
       - Useful for quickly checking how contract functions behave.


       - First deploy contract with Anvil.
       - Use Cast to read/write using the local contract address.
       - Example: cast call returns value, cast send updates value.


    4. Can also deploy the contract without the script file using- "forge create" command line.   
    */
}
