// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Task9_ERC20_1.sol";

contract SomethingToken is Task9_ERC20_1 {
    constructor() Task9_ERC20_1("Something", "SOME", 9, 100) {}
}
