// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Ownable.sol";

abstract contract Balances is Ownable {
    function getBalance() public view onlyOwner returns (uint) {
        return address(this).balance;
    }

    // function withdraw(address payable _to) public override virtual onlyOwner {
    function withdraw(address payable _to) public virtual override onlyOwner {
        _to.transfer(getBalance());
    }
}
