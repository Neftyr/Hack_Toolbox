// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Calypto} from "../src/Calypto.sol";

contract DeployCalypto is Script {
    function run() external returns (Calypto) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        Calypto calypto = new Calypto();
        vm.stopBroadcast();

        return (calypto);
    }
}
