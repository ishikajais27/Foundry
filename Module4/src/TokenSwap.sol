// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TokenSwap {
      mapping (address => uint256) public BalanceOfTokenA;
      mapping (address => uint256) public BalanceOfTokenB;
  function setBalances(address user, uint256 a, uint256 b) public {
    BalanceOfTokenA[user] = a;
    BalanceOfTokenB[user] = b;
}
   function swapAToB(uint256 amount) public payable{
    require(amount>0, "Insuffecient Amount");
    require(BalanceOfTokenA[msg.sender]>0,"Insuffecient Balance");
      BalanceOfTokenA[msg.sender] -= amount;
        BalanceOfTokenB[msg.sender] += amount;
   } 

  function swapBToA(uint256 amount) public {
        require(amount > 0, "Invalid amount");
        require(BalanceOfTokenB[msg.sender] >= amount, "Insufficient Token B");

        BalanceOfTokenB[msg.sender] -= amount;
        BalanceOfTokenA[msg.sender] += amount;
    }
   
}
