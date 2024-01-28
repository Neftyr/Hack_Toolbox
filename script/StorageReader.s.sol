// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract StorageReader is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0x74cd37DfCD91a4eb294213B370EFc3Fb03a45300;
    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;
    address private constant PROXY = 0x0aEd31F9Be33403A0D38d886d8b1199996F2A864;

    function run() external {
        vm.startBroadcast(HACKER);
        getStorageData(TARGET);
        vm.stopBroadcast();
    }

    function getStorageData(address targetContract) public view {
        for (uint256 i = 0; i <= 1; i++) {
            bytes32 value = vm.load(targetContract, bytes32(0));
            console.log("Value at location", i, ":");
            console.log("String: ", string(abi.encodePacked(value)));
            console.log("Address: ", address(uint160(uint256(value))));
            console.log("Number: ", uint256(value));
            console.logBytes32(value);
        }
    }
}
