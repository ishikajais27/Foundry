// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Import OpenZeppelin ERC20 implementation
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    // Set token name and symbol at deployment
    constructor() ERC20("MyToken", "MTK") {}

    // Mint new tokens
    // Automatically updates balanceOf and totalSupply
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    // Burn your own tokens
    // Automatically reduces balance and totalSupply
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Transfer tokens to another address
    // balanceOf updates automatically
    function sendTokens(address to, uint256 amount) public {
        transfer(to, amount); // ERC20 built-in function
    }
}
