// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {LessonThirteenHelper} from "./LessonThirteenHelper.sol";

interface YourContract {
    function owner() external view returns (address);

    function getNumber() external view returns (int256);
}

contract LessonThirteen {
    error LessonThirteen__NotSolved();

    string private constant LESSON_IMAGE = "ipfs://QmdHgyTYLg3hpjMdf6D9nE7Udwubxk2WvmJtv2KewCd6KM";
    uint256 private constant TARGET_NUMBER = 1337;
    uint256 private LESSON_VERSION = 2;
    uint256 private COURSE_VERSION = 3;

    LessonThirteenHelper private immutable i_helperContract;

    constructor() {
        i_helperContract = new LessonThirteenHelper();
    }

    /*
     * CALL THIS FUNCTION!
     *
     * @param yourContract = the contract you're using to solve this
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(address yourContract, string memory /* yourTwitterHandle */) external {
        YourContract yc = YourContract(yourContract);
        int256 number = yc.getNumber();
        address yourOwner = yc.owner();

        if (yourOwner != msg.sender) revert LessonThirteen__NotSolved();

        /** @dev We are borrowing function named addTen() and calling it in this contract */
        (bool success, bytes memory data) = address(i_helperContract).delegatecall(abi.encodeWithSignature("addTen(int256)", number));

        if (!success) revert LessonThirteen__NotSolved();

        uint256 result = abi.decode(data, (uint256));

        if (result != TARGET_NUMBER) revert LessonThirteen__NotSolved();

        /** @dev REWARD: _updateAndRewardSolver(yourTwitterHandle); */
    }
}
