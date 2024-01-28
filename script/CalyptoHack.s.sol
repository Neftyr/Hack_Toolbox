// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";

contract CalyptoHack is Script {
    error CalyptoHack__HackFailed();

    address private constant TARGET = 0xE06bb7D4Cae7977c227b17859163707994879532;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        hack();
        vm.stopBroadcast();
    }

    function hack() internal {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("startHack()"));
        if (!success) revert CalyptoHack__HackFailed();
    }
}
