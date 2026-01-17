// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DigiBank} from "../src/DigiBank.sol";

contract DeployDigiBank is Script {
    function run() external {
        vm.startBroadcast();

        new DigiBank(msg.sender);

        vm.stopBroadcast();
    }
}
