// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployDynamicNFT, EncodeAndDeployDynamicNFT, NAME, SYMBOL, FIRST_SVG} from "../script/DeployDynamicNFT.s.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";

contract DynamicNFTTest is Test {
    DeployDynamicNFT private s_deployer;
    DynamicNFT private s_dynamicNFT;
    address private immutable i_alice = makeAddr("Alice");
    address private immutable i_bob = makeAddr("Bob");

    function setUp() external {
        s_deployer = new DeployDynamicNFT();
        s_dynamicNFT = s_deployer.run();
    }

    function testStateAfterMintEqualsFirstState() external {
        vm.prank(i_alice);
        s_dynamicNFT.mintNFT();
        console.log(s_dynamicNFT.tokenURI(0));
    }
}

contract EncodeAndDeployDynamicNFTTest is Test {
    EncodeAndDeployDynamicNFT private s_deployer;
    string private constant RAW_SVG = '<svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 10V3M12 3L9 6M12 3L15 6M6 12L5 11M18 12L19 11M3 18H21M5 21H19M7 18C7 15.2386 9.23858 13 12 13C14.7614 13 17 15.2386 17 18" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';

    function setUp() external {
        s_deployer = new EncodeAndDeployDynamicNFT();
    }

    function testConvertSVGToImageURI() external view {
        string memory encodedSVG = s_deployer.convertSVGToImageURI(RAW_SVG);
        assertEq(encodedSVG, FIRST_SVG);
    }
}