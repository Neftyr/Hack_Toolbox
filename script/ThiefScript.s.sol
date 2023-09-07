// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Thief} from "../src/Thief.sol";

contract ThiefScript is Script {
    error Challenge__HackFailed();

    string private constant NICK = "nseen18";
    bytes4 private constant SELECTOR = 0x82692679;
    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;
    address private constant TARGET = 0x766a74f8924C7B07df088fDB0F7D7DbaDd330Fb3;
    address private constant THIEF = 0x47a299D5289b3b29f7240437190588b579d3a4Df;

    function run() external {
        vm.startPrank(HACKER);
        lastHack();
        vm.stopPrank();
    }

    function lastHack() internal {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("solveChallenge(address,bytes4,string)", THIEF, SELECTOR, NICK));
        if (!success) revert Challenge__HackFailed();
    }
}
