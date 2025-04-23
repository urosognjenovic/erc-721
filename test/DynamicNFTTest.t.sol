// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployDynamicNFT, NAME, SYMBOL} from "../script/DeployDynamicNFT.s.sol";
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
