// Exercise III - Testing Basics in Solidity
// Build a simple bank where users deposit and withdraw. Write tests to ensure the logic works and edge cases are handled.
//
// Concepts You'll Master
// a. forge test
//    → This command runs all test files.
//    → Simple command: `forge test`
//    → It checks if your functions work correctly.
//
// b. assertEq
//    → Used in tests to check if two values are equal.
//    → Example: assertEq(balance, 1 ether);
//    → If not equal → test fails.
//
// c. expectRevert
//    → Used when you EXPECT a function to fail.for "require".
//    → Example: vm.expectRevert(); then call the failing function.
//    → If the function does not fail → test fails.
//
// d. test coverage
//    → Shows how much of your contract code is tested.
//    → Command: `forge coverage`
//    → Higher % means more lines of your contract are tested.

pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract DigiBank{
    address owner;
    constructor(address _owner){
        owner = _owner;
    }
    uint256 public balance;
    function deposit(uint256 amount) external payable{
        require(amount>0,"Insuffecient amount");
        balance+=amount;
    }
    function withdraw(uint256 amount) external payable{
        require(amount<= balance,"Insuffecient balance");
        balance-=amount;
    }
}
