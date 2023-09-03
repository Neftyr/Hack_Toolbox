// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract HackerScript is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0x5c2405e0e4EE969d19C6F6300a98c0937483B7Ac;

    function run() external {
        uint256 deployerKey = vm.envUint("S_PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        (bool success, ) = TARGET.call(abi.encodeWithSignature("hackNFT()"));
        if (!success) revert Challenge__HackFailed();
        vm.stopBroadcast();
    }
}
