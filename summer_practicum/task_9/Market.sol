// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AnythingToken.sol";
import "./SomethingToken.sol";

contract Market is Ownable {
    // SomethingToken private _someToken = new SomethingToken();
    // AnythingToken private _anyToken = new AnythingToken();
    SomethingToken public _someToken;
    AnythingToken public _anyToken;

    // IERC20 public token;

    constructor(
        address somethingTokenAddress,
        address anythingTokenAddress
    ) Ownable(msg.sender) {
        _someToken = SomethingToken(somethingTokenAddress);
        _anyToken = AnythingToken(anythingTokenAddress);
    }

    receive() external payable {
        uint tokensToBuy = msg.value;
        require(tokensToBuy > 0, "not enough funds!");

        require(
            token.balanceOf(address(this)) >= tokensToBuy,
            "not enough tokens!"
        );

        // token.transfer(msg.sender, tokensToBuy);
    }
}
