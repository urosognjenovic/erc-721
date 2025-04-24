// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DynamicNFT is ERC721 {
    enum State {
        First,
        Second
    }

    uint256 private s_tokenCounter;
    string private s_firstSVGImageURI;
    string private s_secondSVGImageURI;
    mapping(uint256 => State) private s_tokenIDToState;

    error NotTokenOwner();

    constructor(
        string memory name,
        string memory symbol,
        string memory firstSVGImageURI,
        string memory secondSVGImageURI
    ) ERC721(name, symbol) {
        s_firstSVGImageURI = firstSVGImageURI;
        s_secondSVGImageURI = secondSVGImageURI;
    }

    function mintNFT() external {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIDToState[s_tokenCounter] = State.First;
        s_tokenCounter++;
    }

    function flipState(uint256 tokenID) external {
        require(msg.sender == ownerOf(tokenID), NotTokenOwner());

        s_tokenIDToState[tokenID] = s_tokenIDToState[tokenID] == State.First ? State.Second : State.First;
    }

    function getNumberOfTokens() external view returns (uint256) {
        return s_tokenCounter;
    }

    function getTokenIDToState(uint256 tokenID) external view returns (State) {
        return s_tokenIDToState[tokenID];
    }

    function tokenURI(uint256 tokenID) public view override returns (string memory) {
        string memory imageURI = s_tokenIDToState[tokenID] == State.First ? s_firstSVGImageURI : s_secondSVGImageURI;

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT that can change.", "attributes": [{"trait_type": "colors", "value": "black-and-white"}], "image": "',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
}
