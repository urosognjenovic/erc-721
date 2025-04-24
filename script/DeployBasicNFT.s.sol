// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

string constant NAME = "BasicNFT";
string constant SYMBOL = "BNFT";

contract DeployBasicNFT is Script {
    function run() external returns (BasicNFT basicNFT) {
        vm.startBroadcast();
        basicNFT = new BasicNFT(NAME, SYMBOL);
        vm.stopBroadcast();
    }
}
