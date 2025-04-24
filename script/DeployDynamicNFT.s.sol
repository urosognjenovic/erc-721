// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

string constant NAME = "DynamicNFT";
string constant SYMBOL = "DNFT";
string constant FIRST_SVG = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBkPSJNMTIgMTBWM00xMiAzTDkgNk0xMiAzTDE1IDZNNiAxMkw1IDExTTE4IDEyTDE5IDExTTMgMThIMjFNNSAyMUgxOU03IDE4QzcgMTUuMjM4NiA5LjIzODU4IDEzIDEyIDEzQzE0Ljc2MTQgMTMgMTcgMTUuMjM4NiAxNyAxOCIgc3Ryb2tlPSIjMDAwMDAwIiBzdHJva2Utd2lkdGg9IjIiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIvPjwvc3ZnPg==";
string constant SECOND_SVG = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBkPSJNNiAxMkw1IDExTTE4IDEyTDE5IDExTTMgMThIMjFNNSAyMUgxOU03IDE4QzcgMTUuMjM4NiA5LjIzODU4IDEzIDEyIDEzQzE0Ljc2MTQgMTMgMTcgMTUuMjM4NiAxNyAxOE0xMiAzVjEwTTEyIDEwTDE1IDdNMTIgMTBMOSA3IiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+PC9zdmc+";

contract DeployDynamicNFT is Script {
    DynamicNFT private s_dynamicNFT;

    function run() external returns (DynamicNFT) {
        vm.startBroadcast();
        s_dynamicNFT = new DynamicNFT(NAME, SYMBOL, FIRST_SVG, SECOND_SVG);
        vm.stopBroadcast();
        return s_dynamicNFT;
    }
}

contract EncodeAndDeployDynamicNFT is Script {
    string constant BASE_URI = "data:image/svg+xml;base64,";

    function run() external returns (DynamicNFT) {}

    function convertSVGToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory svgBase64Encoded = Base64.encode(
            bytes(svg)
        );
        return string.concat(BASE_URI, svgBase64Encoded);
    }
}
