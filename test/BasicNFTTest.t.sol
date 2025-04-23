// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT, NAME, SYMBOL} from "../script/DeployBasicNFT.s.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployBasicNFT private s_deployer;
    BasicNFT private s_basicNFT;
    address private immutable i_alice = makeAddr("Alice");
    address private immutable i_bob = makeAddr("Bob");
    string private constant TOKEN_URI =
        "https://yellow-raw-bear-827.mypinata.cloud/ipfs/bafkreihoixbxvitnwoto7cjipxiin2vsgg7fqypylldzlbzxetkji74pcu";
    uint256 private constant ALICE_BALANCE_AFTER_MINT = 1;

    function setUp() external {
        s_deployer = new DeployBasicNFT();
        s_basicNFT = s_deployer.run();
    }

    function testNameAndSymbol() external view {
        assertEq(s_basicNFT.name(), NAME);
        assertEq(s_basicNFT.symbol(), SYMBOL);
    }

    function testMintAndBalance() external {
        vm.prank(i_alice);
        s_basicNFT.mintNFT(TOKEN_URI);
        assertEq(s_basicNFT.balanceOf(i_alice), ALICE_BALANCE_AFTER_MINT);
        string memory tokenURI = s_basicNFT.tokenURI(
            ALICE_BALANCE_AFTER_MINT - 1
        );
        assertEq(tokenURI, TOKEN_URI);
    }
}
