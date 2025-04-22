// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract MintBasicNFT is Script {
    string private constant TOKEN_URI = "";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        _mintNFT(mostRecentDeployment);
    }

    function _mintNFT(address mostRecentDeployment) internal {
        vm.startBroadcast();
        BasicNFT(mostRecentDeployment).mintNFT(TOKEN_URI);
        vm.stopBroadcast();
    }
}
