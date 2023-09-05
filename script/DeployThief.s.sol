// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Thief} from "../src/Thief.sol";

contract DeployThief is Script {
    function run() external returns (Thief) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        Thief thief = new Thief(1);
        vm.stopBroadcast();

        return (thief);
    }
}
