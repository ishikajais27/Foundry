// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Auction {
    address public highestBidder;
    uint256 public highestBid;
    uint256 public endTime;

    mapping(address => uint256) public refunds;

    event NewBid(address indexed bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    constructor(uint256 duration) {
        endTime = block.timestamp + duration;
    }

    function bid() external payable {
        require(block.timestamp < endTime, "Auction ended");
        require(msg.value > highestBid, "Bid too low");

        if (highestBid != 0) {
            refunds[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit NewBid(msg.sender, msg.value);
    }

    function withdraw() external {
        uint256 amount = refunds[msg.sender];
        require(amount > 0, "No refund");

        refunds[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function endAuction() external {
        require(block.timestamp >= endTime, "Auction not ended");

        emit AuctionEnded(highestBidder, highestBid);
        payable(highestBidder).transfer(highestBid);
    }
}
