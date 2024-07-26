// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BarashERC3.sol";

contract BarashToken3 is BarashERC20_3 {
    constructor() BarashERC20("Barash", "BRSH", 6) Ownable(msg.sender) {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
