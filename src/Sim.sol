// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Sim {
    uint256 private secretNumber;

    constructor(uint256 _secretNumber) {
        secretNumber = _secretNumber;
    }

    function updateSecretNumber(uint256 _newSecretNumber) public {
        secretNumber = _newSecretNumber;
    }
}
