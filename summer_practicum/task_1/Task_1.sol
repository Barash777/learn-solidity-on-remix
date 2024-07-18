// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_1 {
    bool b1 = true;
    bool b2; // false by default

    uint public u1 = 1; // availabe everywhere
    int internal u2 = -23; // available in this contract and in the extended contracts
    uint private u3; // available only in this contract. Note: Zero by default
}
