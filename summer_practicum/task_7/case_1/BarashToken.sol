// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BarashERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BarashToken is BarashERC20, Ownable {
    constructor() BarashERC20("Barash", "BRSH", 6) Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        require(
            account != address(0),
            "Account to mint can't be zero address!"
        );
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        require(
            account != address(0),
            "Account to burn can't be zero address!"
        );
        _update(account, address(0), value);
    }
}
