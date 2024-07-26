// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact barash.vertihvost@gmail.com
contract BarashToken2 is ERC20, Ownable {
    constructor(
        address initialOwner
    ) ERC20("Barash", "BRSH") Ownable(initialOwner) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        _burn(msg.sender, totalSupply() / 2);
    }
}
