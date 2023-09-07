// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Thief {
    error Thief__HackFailed();

    uint256 private s_variable;
    address private immutable owner;
    string private constant HACKER = "nseen18";
    address private constant TARGET = 0x766a74f8924C7B07df088fDB0F7D7DbaDd330Fb3;
    bytes4 private constant SELECTOR = 0x82692679;

    constructor() {
        owner = msg.sender;
    }

    /** @dev Below will not work for challenge as this call will be always made by this contract (so there will be owner error) */
    function lastHack() external {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("solveChallenge(address,bytes4,string)", address(this), SELECTOR, HACKER));
        if (!success) revert Thief__HackFailed();
    }

    function doSomething() external {
        s_variable = 123;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
