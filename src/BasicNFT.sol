// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIDToURI;

    constructor(
        string memory name,
        string memory symbol
    ) ERC721(name, symbol) {}

    function mintNFT(string memory newTokenURI) external {
        s_tokenIDToURI[s_tokenCounter] = newTokenURI;
        _safeMint(msg.sender, s_tokenCounter, "");
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 tokenID
    ) public view override returns (string memory) {
        return s_tokenIDToURI[tokenID];
    }
}
