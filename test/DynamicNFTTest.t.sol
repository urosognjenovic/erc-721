// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployDynamicNFT, EncodeAndDeployDynamicNFT, NAME, SYMBOL, FIRST_SVG, SECOND_SVG} from "../script/DeployDynamicNFT.s.sol";
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
    DynamicNFT private s_dynamicNFT;
    address private immutable i_alice = makeAddr("Alice");
    address private immutable i_bob = makeAddr("Bob");
    uint256 private constant FIRST_TOKEN_ID = 0;
    uint256 private constant NUMBER_OF_TOKENS_AFTER_TWO_MINTS = 2;
    string private constant EXPECTED_TOKEN_URI_AFTER_FLIP =
        "data:application/json;base64,eyJuYW1lIjogIkR5bmFtaWNORlQiLCAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHRoYXQgY2FuIGNoYW5nZS4iLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAiY29sb3JzIiwgInZhbHVlIjogImJsYWNrLWFuZC13aGl0ZSJ9XSwgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjNhV1IwYUQwaU9EQXdjSGdpSUdobGFXZG9kRDBpT0RBd2NIZ2lJSFpwWlhkQ2IzZzlJakFnTUNBeU5DQXlOQ0lnWm1sc2JEMGlibTl1WlNJZ2VHMXNibk05SW1oMGRIQTZMeTkzZDNjdWR6TXViM0puTHpJd01EQXZjM1puSWo0OGNHRjBhQ0JrUFNKTk5pQXhNa3cxSURFeFRURTRJREV5VERFNUlERXhUVE1nTVRoSU1qRk5OU0F5TVVneE9VMDNJREU0UXpjZ01UVXVNak00TmlBNUxqSXpPRFU0SURFeklERXlJREV6UXpFMExqYzJNVFFnTVRNZ01UY2dNVFV1TWpNNE5pQXhOeUF4T0UweE1pQXpWakV3VFRFeUlERXdUREUxSURkTk1USWdNVEJNT1NBM0lpQnpkSEp2YTJVOUlpTXdNREF3TURBaUlITjBjbTlyWlMxM2FXUjBhRDBpTWlJZ2MzUnliMnRsTFd4cGJtVmpZWEE5SW5KdmRXNWtJaUJ6ZEhKdmEyVXRiR2x1WldwdmFXNDlJbkp2ZFc1a0lpOCtQQzl6ZG1jKyJ9";

    string private constant RAW_SVG =
        '<svg width="800px" height="800px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 10V3M12 3L9 6M12 3L15 6M6 12L5 11M18 12L19 11M3 18H21M5 21H19M7 18C7 15.2386 9.23858 13 12 13C14.7614 13 17 15.2386 17 18" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';

    function setUp() external {
        s_deployer = new EncodeAndDeployDynamicNFT();
        s_dynamicNFT = s_deployer.run();
    }

    function testConvertSVGToImageURI() external view {
        string memory encodedSVG = s_deployer.convertSVGToImageURI(RAW_SVG);
        assertEq(encodedSVG, FIRST_SVG);
    }

    function testFlipState() external {
        vm.startPrank(i_alice);
        s_dynamicNFT.mintNFT();
        s_dynamicNFT.flipState(FIRST_TOKEN_ID);
        vm.stopPrank();
        uint256 expectedStateUint256 = uint256(DynamicNFT.State.Second);
        uint256 actualStateUint256 = uint256(s_dynamicNFT.getTokenIDToState(FIRST_TOKEN_ID));

        assertEq(actualStateUint256, expectedStateUint256);
        assertEq(s_dynamicNFT.tokenURI(FIRST_TOKEN_ID), EXPECTED_TOKEN_URI_AFTER_FLIP);
    }

    function testFlipStateRevertsIfNotTokenOwner() external {
        vm.prank(i_alice);
        s_dynamicNFT.mintNFT();
        vm.prank(i_bob);
        vm.expectRevert(DynamicNFT.NotTokenOwner.selector);
        s_dynamicNFT.flipState(FIRST_TOKEN_ID);
    }

    function testConstructorInitializations() external {
        s_dynamicNFT = new DynamicNFT(NAME, SYMBOL, FIRST_SVG, SECOND_SVG);
        string memory actualName = s_dynamicNFT.name();
        assertEq(actualName, NAME);
        string memory actualSymbol = s_dynamicNFT.symbol();
        assertEq(actualSymbol, SYMBOL);
        (string memory actualFirstSVG, string memory actualSecondSVG) = s_dynamicNFT.getImageURIs();
        string memory expectedFirstSVG = s_deployer.convertSVGToImageURI(vm.readFile("./svg/firstImage.svg"));
        assertEq(actualFirstSVG, expectedFirstSVG);
        string memory expectedSecondSVG = s_deployer.convertSVGToImageURI(vm.readFile("./svg/secondImage.svg"));
        assertEq(actualSecondSVG, expectedSecondSVG);
    }

    function testGetNumberOfTokensAfterTwoMints() external {
        vm.startPrank(i_alice);
        s_dynamicNFT.mintNFT();
        s_dynamicNFT.mintNFT();
        vm.stopPrank();
        uint256 numberOfTokens = s_dynamicNFT.getNumberOfTokens();
        assertEq(numberOfTokens, NUMBER_OF_TOKENS_AFTER_TWO_MINTS);
    }
}
