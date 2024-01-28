// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Calypto {
    error Calypto__HackFailed();

    address private constant TARGET = 0xF3C37E8025Ff444348e163B3846aF042729E818F;

    function startHack() external {
        string memory hacker = "Nlferu -> GitHub";
        bytes4 selector = getHackSelector();

        /** @dev If we use `.call` msg.sender will be this contract | If we use `.delegatecall` msg.sender will be tx.origin, so our wallet from private key */
        (bool success, ) = TARGET.call(abi.encodeWithSignature("enrollWinner(bytes4,string)", selector, hacker));
        if (!success) revert Calypto__HackFailed();
    }

    function checkData() private returns (uint256, bytes4, bool) {
        (bool success, bytes memory data) = address(this).delegatecall(abi.encodeWithSignature("hackVictim()"));

        uint256 result;
        assembly {
            result := mload(add(data, 32))
        }

        return (result, bytes4(data), success);
    }

    function hackVictim() external pure returns (uint256) {
        uint256 res = 999;

        return res;
    }

    function getHackSelector() internal pure returns (bytes4 selector) {
        return selector = bytes4(keccak256(bytes("hackVictim()")));
    }
}
