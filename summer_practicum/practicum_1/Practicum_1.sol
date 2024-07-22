// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Practicum_1 {
    uint number = 123;
    address wallet;
    bool trigger = false;

    int constant JUST_CONTSTANT = 1;
    address immutable testImmutableAddress;
    address owner;

    constructor() {
        testImmutableAddress = msg.sender;
        owner = msg.sender;
    }

    mapping(address => uint) payments;

    uint[] DArray;

    modifier isOwner(address _to) {
        require(_to == owner, "You are not an owner");
        _;
    }

    modifier isZeroAddress(address _to) {
        require(_to != address(0), "Zero address");
        _;
    }

    mapping(address => mapping(uint => bool)) paymentStatus;

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Person {
        string name;
        uint8 age;
        Payment[] payments; // array of structures
    }

    mapping(address => Person) clients;

    function changeOwner(address _newOwner) public isZeroAddress(_newOwner) {
        owner = _newOwner;
    }

    /*
        NOTE: В задании написано "написать функцию, которая будет задавать immutable значение в конструкторе"
        Может это просто ошибка в задании, но у меня не получилось создать такую функцию
        Можно лишь задать значение внутри конструктора!
     */
    // function setImmutableAddress(address _newOwner) private {
    //     testImmutableAddress = _newOwner;
    // }

    function addElementToDArray(uint _element) public {
        DArray.push(_element);
    }

    function removeLastElementFromDArray() public {
        DArray.pop();
    }

    function removeElementFromDArray(uint _element) public {
        for (uint i = DArray.length; i >= 0; i--) {
            if (DArray[i] == _element) {
                delete DArray[i];
                return;
            }
        }
    }

    function getDArraySize() public view returns (uint) {
        return DArray.length;
    }
}
