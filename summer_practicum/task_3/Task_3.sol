// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_3 {
    enum PaymentProgress { No, Pending, Success, Fail }
    PaymentProgress value;

    bytes b1 = "test";
    bytes32 b2 = "test 32";

    uint[2] FixedArray = [1,2];
    uint[] DynamicArray = [1,2,3,4,5,6];

    struct Person {
        address wallet;
        string name;
        uint8 age;
    }

    function increaseArraySize() public {
        DynamicArray.push(DynamicArray.length + 1);
    }

    function getArraySize() public view returns(uint) {
        return DynamicArray.length;
    }
}
