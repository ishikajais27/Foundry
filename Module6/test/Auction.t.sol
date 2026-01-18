// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Auction.sol";

contract AuctionTest is Test {
    Auction auction;

    address alice = address(0x1);
    address bob   = address(0x2);
    address charlie = address(0x3);

    function setUp() public {
        auction = new Auction(1 days);

        // Give users ETH to bid
        vm.deal(alice, 5 ether);
        vm.deal(bob, 5 ether);
        vm.deal(charlie, 5 ether);
    }

    // --- Test bid function ---
    function testBid() public {
        // Alice bids 1 ETH
        vm.expectEmit(true, true, false, true);
        emit Auction.NewBid(alice, 1 ether);
        auction.bid{value: 1 ether, from: alice}();

        // Bob bids 2 ETH
        vm.expectEmit(true, true, false, true);
        emit Auction.NewBid(bob, 2 ether);
        auction.bid{value: 2 ether, from: bob}();

        // Check highest bid and bidder
        assertEq(auction.highestBid(), 2 ether);
        assertEq(auction.highestBidder(), bob);

        // Alice should have refund
        assertEq(auction.refunds(alice), 1 ether);
    }

    // --- Test withdraw function ---
    function testWithdraw() public {
        // Alice bids 1 ETH
        auction.bid{value: 1 ether, from: alice}();

        // Bob bids 2 ETH
        auction.bid{value: 2 ether, from: bob}();

        // Alice withdraws refund
        uint balanceBefore = alice.balance;
        auction.withdraw{from: alice}();
        uint balanceAfter = alice.balance;

        assertEq(balanceAfter - balanceBefore, 1 ether);
    }

    // --- Test endAuction with time travel ---
    function testEndAuction() public {
        auction.bid{value: 1 ether, from: alice}();

        // Warp time 2 days to end auction
        vm.warp(block.timestamp + 2 days);

        vm.expectEmit(true, true, false, true);
        emit Auction.AuctionEnded(alice, 1 ether);

        uint balanceBefore = alice.balance;
        auction.endAuction();
        uint balanceAfter = alice.balance;

        assertEq(balanceAfter - balanceBefore, 1 ether);
    }

    // --- Test bid after auction ends fails ---
    function testBidAfterEndFails() public {
        vm.warp(block.timestamp + 2 days);
        vm.expectRevert(bytes("Auction ended"));
        auction.bid{value: 1 ether, from: bob}();
    }

    // --- Test endAuction before auction ends fails ---
    function testEndAuctionBeforeTimeFails() public {
        vm.warp(block.timestamp + 12 hours);
        vm.expectRevert(bytes("Auction not ended yet"));
        auction.endAuction();
    }
}
