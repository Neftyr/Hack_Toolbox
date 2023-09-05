// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Thief_v13 {
    error Thief_v13__HackFailed();

    int256 private KEY;
    address private immutable HACKER;
    string private constant ATTACKER = "nseen18";
    address private constant TARGET = 0xaFa4150818b7843345A5E54E430Bd0cAE31B5c0C;

    constructor() {
        HACKER = msg.sender;
        calculateKey();
    }

    function stealNFT() external {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("solveChallenge(address,string)", address(this), ATTACKER));
        if (!success) revert Thief_v13__HackFailed();
    }

    /** @dev INFO:
     * 572038313094850821099624258919152072749626292365 -> from reading storage[0] of 0xaFa4150818b7843345A5E54E430Bd0cAE31B5c0C
     * From helper we got (X + 572038313094850821099624258919152072749626292365 + 10 = 1337)
     * So our X will be -> X = -572038313094850821099624258919152072749626291038;
     */
    function calculateKey() internal {
        uint256 TARGET_NUMBER = 1337;

        int256 X = int256(TARGET_NUMBER) - 572038313094850821099624258919152072749626292365 - int256(10);
        KEY = X;
    }

    /** @dev We need to call it in separate script */
    // function getStorageData() internal view returns (uint256) {
    //     bytes32 value = vm.load(TARGET, bytes32(0));

    //     return uint256(value); // 572038313094850821099624258919152072749626292365
    // }

    function owner() external view returns (address) {
        return HACKER;
    }

    function getNumber() external view returns (int256) {
        return KEY;
    }
}
