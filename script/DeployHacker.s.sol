// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Hacker} from "../src/Hacker.sol";

contract DeployHacker is Script {
    function run() external returns (Hacker) {
        uint256 deployerKey = vm.envUint("S_PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        Hacker hacker = new Hacker();
        vm.stopBroadcast();

        return (hacker);
    }
}
