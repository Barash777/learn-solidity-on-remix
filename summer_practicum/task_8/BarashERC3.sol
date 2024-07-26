// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../task_7/case_1/BarashERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract BarashERC20_3 is BarashERC20, Ownable {
    // 7. Tokens with Blocklists.
    // Токены, типа USDC, USDT, имеют свои функции добавления пользователей в черный список.\
    mapping(address => bool) blockList;

    /**
     * @dev Modifier to check for address from blockList
     *
     * @param _adr address to check from blockList
     */
    modifier isAddressBlocked(address _adr) {
        require(blockList[_adr] == false, "This address is in block list!");
        _;
    }

    /**
     * Function to add address to blockList
     *
     * @param _adr address to add to blockList
     */
    function addAddressToBlockList(address _adr) public onlyOwner {
        blockList[_adr] = true;
    }

    // Если адрес заблокирован, то транзакция будет постоянно откатываться.
    // 11. Revert on Zero Value Transfers.
    // Токены LEND откатывают транзакции, если указано нулевое количество токенов.
    modifier moreThanZero(uint256 value) {
        require(value > 0, "Value should be more than 0!");
        _;
    }

    function transfer(
        address to,
        uint256 value
    ) public override(BarashERC20) moreThanZero(value) returns (bool) {
        return super.transfer(to, value);
    }

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public override(BarashERC20) moreThanZero(value) returns (bool) {
        return super.transferFrom(from, to, value);
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
