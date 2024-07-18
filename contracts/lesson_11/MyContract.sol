// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./Balances.sol";

contract MyContract is Ownable, Balances {
    constructor(address _owner) {
        owner = _owner;
    }

    function withdraw(
        address payable _to
    ) public override(Ownable, Balances) onlyOwner {
        // Balances.withdraw(_to); // equal to 'super.withdraw(_to);'
        // Ownable.withdraw(_to);
        require(_to != address(0), "zero address");
        super.withdraw(_to); // parent one level above
    }
}
