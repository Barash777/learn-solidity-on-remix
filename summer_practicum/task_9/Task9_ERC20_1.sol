// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract Task9_ERC20_1 is ERC20 {
    uint8 private _decimals;

    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initTokensCount
    ) ERC20(name_, symbol_) {
        _decimals = decimals_;
        _mint(msg.sender, initTokensCount * 10 ** decimals());
    }

    function decimals() public view override(ERC20) returns (uint8) {
        return _decimals;
    }
}
