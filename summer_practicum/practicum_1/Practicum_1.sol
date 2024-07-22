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
    mapping(address => string) public paymentsMessages;

    uint[] public DArray;

    modifier isOwner(address _to) {
        require(_to == owner, "You are not an owner");
        _;
    }

    modifier isZeroAddress(address _to) {
        require(_to != address(0), "Zero address");
        _;
    }

    // странный мэппинг, не придумал вариант из жизни, но для обучения пойдет :)
    mapping(address => mapping(uint => bool)) public paymentStatus;

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Person {
        string name;
        uint8 age;
        Payment payment;
    }

    mapping(address => Person) public clients;

    Payment[] public paymentsArray;

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

    function removeElementByIndexFromDArray(uint _index) public {
        require(DArray.length > _index, "index is out of the array length!");

        for (uint i = _index; i < DArray.length - 1; i++) {
            DArray[i] = DArray[i + 1];
        }

        DArray.pop();
    }

    function getDArraySize() public view returns (uint) {
        return DArray.length;
    }

    function addPaymentStatus(
        address _address,
        uint _amount,
        bool _received
    ) public {
        paymentStatus[_address][_amount] = _received;
    }

    function removePaymentStatus(address _address, uint _amount) public {
        delete paymentStatus[_address][_amount];
    }

    function addClient(
        address _address,
        string calldata _name,
        uint8 _age,
        uint _amount
    ) public {
        Person memory person = Person(
            _name,
            _age,
            Payment(_amount, block.timestamp)
        );

        clients[_address] = person;
    }

    function addNewPayment(uint _amount) public {
        paymentsArray.push(Payment(_amount, block.timestamp));
    }

    function pay() public payable {
        paymentsMessages[msg.sender] = "We received ETH from this address";
    }
}
