// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task_4 {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    uint number = 123;
    address wallet = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bool b = true;
    string str = "Test string";

    address constant JUST_WALLET_NUMBER =
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint constant JUST_NUMBER = 3;

    mapping(address => uint) payments;

    uint8[4] fixedArray = [1, 3, 5, 6];
    uint8[] DynamicArray;

    enum DayRoutine {
        Sleep,
        Eat,
        Work,
        Walk,
        PlayPS
    }

    modifier isOwner(address _to) {
        require(_to == owner, "You are not an owner");
        _;
    }

    modifier isZeroAddress(address _to) {
        require(_to != address(0), "Zero address");
        _;
    }

    event Payment(address _from, uint _amount, uint _timestamp);
    event WalletUpdate(address _newAddress);

    error BalanceIsTooSmall(uint256 _balance, uint256 _withdrawAmount);
    error MinValue(uint _min, uint _value);

    function increment() public {
        number++;
    }

    function decrement() public {
        number -= JUST_NUMBER;
    }

    function addSomeNumbers(uint _a, uint _b) public {
        number += _a + _b + JUST_NUMBER;
    }

    function addPayment(address _to, uint _amount) public {
        payments[_to] += _amount;
    }

    function changeOwner(
        address _newAddress
    )
        public
        // can't change owner address when we check for owner!!!
        // will check just for zero address
        // ) public isZeroAddress(_newAddress) isOwner(_newAddress) {
        isZeroAddress(_newAddress)
    {
        owner = _newAddress;
    }

    function sum(uint _a, uint _b) public pure returns (uint) {
        uint min = 10;
        if (_a < 10) revert MinValue(min, _a);
        if (_b < 10) revert MinValue(min, _b);
        return _a + _b;
    }
}
