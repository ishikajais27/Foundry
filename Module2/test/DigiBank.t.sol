// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {DigiBank} from "../src/DigiBank.sol";

contract DigiBankTest is Test {
    DigiBank public digibank;

    function setUp() public {
        digibank = new DigiBank(address(this));
    }   

function testDeposit() public {
    digibank.deposit{value: 1 ether}(1 ether);
    assertEq(digibank.balance(), 1 ether);
}


   function testWithdraw() public {
    digibank.deposit{value: 2 ether}(2 ether);
    digibank.withdraw(1 ether);
    assertEq(digibank.balance(), 1 ether);
}

function testDepositRevertOnZeroAmount() public {
    vm.expectRevert(bytes("Insuffecient amount"));
    digibank.deposit{value: 0}(0);   // this should fail
}

function testWithdrawRevertOnHighAmount() public {
    digibank.deposit{value: 1 ether}(1 ether);

    vm.expectRevert(bytes("Insuffecient balance"));
    digibank.withdraw(2 ether);      // this should fail
}


}
