// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";

contract MintBasicNFT is Script {
    string private constant TOKEN_URI =
        "https://yellow-raw-bear-827.mypinata.cloud/ipfs/bafkreihoixbxvitnwoto7cjipxiin2vsgg7fqypylldzlbzxetkji74pcu";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("BasicNFT", block.chainid);
        _mintNFT(mostRecentDeployment);
    }

    function _mintNFT(address mostRecentDeployment) internal {
        vm.startBroadcast();
        BasicNFT(mostRecentDeployment).mintNFT(TOKEN_URI);
        vm.stopBroadcast();
    }
}

contract MintDynamicNFT is Script {
    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("DynamicNFT", block.chainid);

        _mintNFT(mostRecentDeployment);
    }

    function _mintNFT(address mostRecentDeployment) internal {
        vm.startBroadcast();
        DynamicNFT(mostRecentDeployment).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipDynamicNFTState is Script {
    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("DynamicNFT", block.chainid);
        uint256 mostRecentTokenID = DynamicNFT(mostRecentDeployment).getNumberOfTokens() - 1;

        _flipState(mostRecentDeployment, mostRecentTokenID);
    }

    function _flipState(address mostRecentDeployment, uint256 mostRecentTokenID) internal {
        DynamicNFT(mostRecentDeployment).flipState(mostRecentTokenID);
    }
}
