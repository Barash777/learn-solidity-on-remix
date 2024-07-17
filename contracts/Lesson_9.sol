// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Optimized {
    // uint demo; // gas 66854

    // // vars a and b will be put in the one cell because are inited conseq
    // // gas = 113298
    // uint128 a = 1;
    // uint128 b = 1;
    // uint256 c = 1;

    // uint demo2 = 1; // if there is just one var then better to use uint256
    // uint8[] demo = [1,2,3]; // but for arrays better to set uint8 or uint16 instead of just uint

    // better to add hash hardcoded
    // bytes32 hash = 0x70997970C51812dc3A010C7d01b50e0d17;

    // 1. Dynamic array is too expensive (x2 more expensive with comparing of fixed arrays)
    // 2. Better to use mapping instead of arrays

    // // gas 23494
    // mapping(address => uint) payments;
    // function pay() external payable {
    //     require(msg.sender != address(0), "address is zero");
    //     payments[msg.sender] = msg.value;
    // }

    // // gas 23457
    // uint[10] paymentsAr;
    // function payAr() external payable {
    //     require(msg.sender != address(0), "address is zero");
    //     paymentsAr[0] = msg.value;
    // }

    // // Better to use one function instead of couple small functions
    // uint c = 5;
    // uint d;
    // // gas 46124
    // function calc() public {
    //     uint a = 1 + c;
    //     uint b = 3 * c;
    //     d = a + b;
    // }

    // use short strings (less than 32 bytes)

    // // rewrite state var as less as possible times (don't mpdify it in the cycle)
    // uint public result = 1;
    // function doSomething(uint[] memory data) public {
    //     uint temp = 1;
    //     for (uint i; i < data.length; i++) {
    //         temp *= data[i];
    //     }
    //     result = temp;
    // }

}

contract NotOptimized {
    // uint demo = 0; // gas 69107

    // // vars a and b will NOT be put in the one cell because are inited NOT conseq
    // // gas = 135136
    // uint128 a = 1;
    // uint256 c = 1;
    // uint128 b = 1;

    // uint8 demo2 = 1; // if there is just one var then better to use uint256 instead of uint8
    // uint[] demo = [1,2,3]; // but for arrays better to set uint8 or uint16 instead of just uint

    // better to add hash hardcoded instead of calling functions
    // bytes32 hash = keccak256(abi.encodePacked("test"));

    // mapping(address => uint) payments;
    // function pay() external payable {
    //     // creation of one more var cost is 14 gas
    //     address _from = msg.sender;
    //     require(_from != address(0), "address is zero");
    //     payments[_from] = msg.value;
    // }

    // // gas 46576
    // uint[] paymentsAr;
    // function payAr() external payable {
    //     require(msg.sender != address(0), "address is zero");
    //     paymentsAr.push(msg.value);
    // }

    // // Better to use one function instead of couple small functions
    // uint c = 5;
    // uint d;
    // // gas 46158
    // function calc() public {
    //     uint a = 1 + c;
    //     uint b = 3 * c;
    //     calcResult(a, b);
    // }

    // // better to move the code of this function inside of the calc function
    // function calcResult(uint a, uint b) private {
    //     d = a + b;
    // }

    // // rewrite state var as less as possible times (don't modify it in the cycle)
    // uint public result = 1;
    // function doSomething(uint[] memory data) public {
    //     // uint temp = 1;
    //     for (uint i; i < data.length; i++) {
    //         // temp *= data[i];
    //         result *= data[i];
    //     }
    //     // result = temp;
    // }
}
