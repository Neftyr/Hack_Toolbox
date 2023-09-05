// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract StorageReader is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0xaFa4150818b7843345A5E54E430Bd0cAE31B5c0C;
    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;
    address private constant PROXY = 0x0aEd31F9Be33403A0D38d886d8b1199996F2A864;

    function run() external {
        vm.startPrank(HACKER);
        getStorageData(TARGET);
        vm.stopPrank();
    }

    function getStorageData(address targetContract) public view {
        for (uint256 i = 0; i <= 6; i++) {
            bytes32 value = vm.load(targetContract, bytes32(i));
            console.log("Value at location", i, ":");
            console.log("String: ", string(abi.encodePacked(value)));
            console.log("Address: ", address(uint160(uint256(value))));
            console.log("Number: ", uint256(value));
            console.logBytes32(value);
        }
    }
}
