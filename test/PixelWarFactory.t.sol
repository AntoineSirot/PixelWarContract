// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract PixelGrid is Test {
    PixelGrid public pixelGrid;

    function setUp() public {
        pixelGrid = new PixelGrid();
    }

}
