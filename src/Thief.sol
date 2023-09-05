// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Thief {
    error Thief__HackFailed();

    address private constant TARGET = 0xaFa4150818b7843345A5E54E430Bd0cAE31B5c0C;
    address private immutable HACKER;
    string private constant ATTACKER = "nseen18";
    int256 private key;

    constructor(int256 _basicKey) {
        HACKER = msg.sender;
        key = _basicKey;
    }

    function stealNFT() external {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("solveChallenge(address,string)", address(this), ATTACKER));
        if (!success) revert Thief__HackFailed();
    }

    function calculateKey() external {
        uint256 TARGET_NUMBER = 1337;

        int256 ourNum = int256(TARGET_NUMBER) - 100 - int256(10);
        key = ourNum;
    }

    function setKey(int256 newKey) external {
        key = newKey;
    }

    function owner() external view returns (address) {
        return HACKER;
    }

    function getNumber() external view returns (int256) {
        return key;
    }
}
