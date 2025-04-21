// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT, NAME, SYMBOL} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT private s_deployer;
    BasicNFT private s_basicNFT;

    function setUp() external {
        s_deployer = new DeployBasicNFT();
        s_basicNFT = s_deployer.run();
    }

    function testNameAndSymbol() external view {
        assertEq(s_basicNFT.name(), NAME);
        assertEq(s_basicNFT.symbol(), SYMBOL);
    }
}