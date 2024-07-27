// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AnythingToken.sol";
import "./SomethingToken.sol";

contract Market is Ownable {
    SomethingToken public someToken = new SomethingToken();
    AnythingToken public anyToken = new AnythingToken();

    constructor() Ownable(msg.sender) {}
}
