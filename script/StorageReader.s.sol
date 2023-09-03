// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract HackExploit is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0xe5760847db2f10A74Fc575B4803df5fe129811C1;
    address private constant HACKER = 0xcb11F38172fb2552938C2eEAf873339029DD52e3;

    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        printStorageData(TARGET);

        vm.stopBroadcast();
    }

    function printStorageData(address contractAddress) public view {
        for (uint256 i = 0; i <= 6; i++) {
            bytes32 value = vm.load(contractAddress, bytes32(i));
            console.log("Value at location", i, ":");
            console.log("Address: ", address(uint160(uint256(value))));
            console.log("Number: ", uint256(value));
            console.logBytes32(value);
        }
    }
}
