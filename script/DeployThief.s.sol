// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {Thief_v13} from "../src/Thief_v13.sol";

contract DeployThief is Script {
    function run() external returns (Thief_v13) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        Thief_v13 thief = new Thief_v13();
        vm.stopBroadcast();

        return (thief);
    }
}
