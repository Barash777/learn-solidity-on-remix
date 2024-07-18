// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ILogger.sol";

contract Lesson_12 {
    ILogger logger;

    constructor(address _logger) {
        logger = ILogger(_logger);
    }

    function getPayment(address _from, uint _index) public view returns (uint) {
        return logger.getEntry(_from, _index);
    }

    receive() external payable {
        logger.log(msg.sender, msg.value);
    }
}
