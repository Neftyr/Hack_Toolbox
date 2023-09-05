// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract HackerScript is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0x1C11521f858dd24263133C4cCE9b7e7081061463;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);
        (bool success, ) = TARGET.call(abi.encodeWithSignature("stealNFT()"));
        if (!success) revert Challenge__HackFailed();
        vm.stopBroadcast();
    }
}
