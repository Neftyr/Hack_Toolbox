// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Thief} from "../src/Thief.sol";

contract ThiefScript is Script {
    error Challenge__HackFailed();

    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;

    function run() external {
        vm.startPrank(HACKER);
        Thief thief = new Thief();
        (bool success, ) = address(thief).call(abi.encodeWithSignature("lastHack()"));
        if (!success) revert Challenge__HackFailed();
        vm.stopPrank();
    }
}
