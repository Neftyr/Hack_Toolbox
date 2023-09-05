// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";

contract Hastur_v13 is Script {
    error Challenge__HackFailed();

    address private constant TARGET = 0xaFa4150818b7843345A5E54E430Bd0cAE31B5c0C;
    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;
    address private constant ATTACKER = 0x9cBBf21f6c99BbaAA42016665C739E7a2bC05B9c;
    string private constant NICK = "nseen18";

    function run() external {
        //vm.startBroadcast(HACKER);
        vm.startPrank(HACKER);
        (bool success, ) = TARGET.call(abi.encodeWithSignature("solveChallenge(address,string)", ATTACKER, NICK));
        if (!success) revert Challenge__HackFailed();
        vm.stopPrank();
        //vm.stopBroadcast();
    }
}
