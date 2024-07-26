// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Task9_ERC20_1.sol";

contract Task9_Token_1 is Task9_ERC20_1 {
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initTokensCount
    ) Task9_ERC20_1(name_, symbol_, decimals_, initTokensCount) {}
}
