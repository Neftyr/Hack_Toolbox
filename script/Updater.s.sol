// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract Updater is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0x77ec58b4f6EE53c06752Ec4B5DA4be3c45018204;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        (bool success, ) = TARGET.call(abi.encodeWithSignature("updateSecretNumber(uint256)", 788));
        if (!success) revert Challenge__HackFailed();
        vm.stopBroadcast();
    }
}
