// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenSwap.sol";

contract TokenSwapCombinedTest is Test {
    TokenSwap swap;
    address user = address(1);

    function setUp() public {
        swap = new TokenSwap();
    swap.setBalances(user, 1000, 1000);

    }

    function testFuzz_swapAToB(uint256 amount) public {
        vm.assume(amount > 0 && amount <= 1000);

        uint256 aBefore = swap.BalanceOfTokenA(user);
        uint256 bBefore = swap.BalanceOfTokenB(user);

        swap.swapAToB(amount);

        assertEq(swap.BalanceOfTokenA(user), aBefore - amount);
        assertEq(swap.BalanceOfTokenB(user), bBefore + amount);
        assertEq(
            swap.BalanceOfTokenA(user) + swap.BalanceOfTokenB(user),
            2000
        );
    }
}
