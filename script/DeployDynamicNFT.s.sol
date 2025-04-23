// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {DynamicNFT} from "../src/DynamicNFT.sol";

string constant NAME = "DynamicNFT";
string constant SYMBOL = "DNFT";
string constant FIRST_SVG = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCjxwYXRoIGQ9Ik0xMiAxMFYzTTEyIDNMOSA2TTEyIDNMMTUgNk02IDEyTDUgMTFNMTggMTJMMTkgMTFNMyAxOEgyMU01IDIxSDE5TTcgMThDNyAxNS4yMzg2IDkuMjM4NTggMTMgMTIgMTNDMTQuNzYxNCAxMyAxNyAxNS4yMzg2IDE3IDE4IiBzdHJva2U9IiMwMDAwMDAiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+DQo8L3N2Zz4=";
string constant SECOND_SVG = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iODAwcHgiIGhlaWdodD0iODAwcHgiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCjxwYXRoIGQ9Ik02IDEyTDUgMTFNMTggMTJMMTkgMTFNMyAxOEgyMU01IDIxSDE5TTcgMThDNyAxNS4yMzg2IDkuMjM4NTggMTMgMTIgMTNDMTQuNzYxNCAxMyAxNyAxNS4yMzg2IDE3IDE4TTEyIDNWMTBNMTIgMTBMMTUgN00xMiAxMEw5IDciIHN0cm9rZT0iIzAwMDAwMCIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4NCjwvc3ZnPg==";

contract DeployDynamicNFT is Script {
    DynamicNFT private s_dynamicNFT;

    function run() external returns (DynamicNFT) {
        vm.startBroadcast();
        s_dynamicNFT = new DynamicNFT(NAME, SYMBOL, FIRST_SVG, SECOND_SVG);
        vm.stopBroadcast();
        return s_dynamicNFT;
    }
}
