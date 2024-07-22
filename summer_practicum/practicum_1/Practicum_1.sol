// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Utils.sol";

contract Practicum_1 is Utils {
    uint number = 123;
    address wallet;
    bool trigger = true;

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

    modifier isOwner() {
        require(msg.sender == owner, "You are not an owner");
        _;
    }

    modifier isZeroAddress(address _to) {
        require(_to != address(0), "Zero address");
        _;
    }

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

    /**
     * Change contract owner
     *
     * @param _newOwner: address of new owner
     */
    function changeOwner(
        address _newOwner
    ) public isZeroAddress(_newOwner) isOwner {
        owner = _newOwner;
    }

    /**
     * Add element to DArray
     *
     * @param _element: element we want to add
     */
    function addElementToDArray(uint _element) public {
        DArray.push(_element);
    }

    /**
     * Remove last element from DArray
     */
    function removeLastElementFromDArray() public {
        DArray.pop();
    }

    /**
     * Remove element from DArray by index
     *
     * @param _index: index in array we want to delete
     */
    function removeElementByIndexFromDArray(uint _index) public {
        require(DArray.length > _index, "index is out of the array length!");

        for (uint i = _index; i < DArray.length - 1; i++) {
            DArray[i] = DArray[i + 1];
        }

        DArray.pop();
    }

    /**
     * Get length of the DArray
     */
    function getDArraySize() public view returns (uint) {
        return DArray.length;
    }

    /**
     * Add payment status to the nested mapping
     *
     * @param _address: sender address
     * @param _amount: payment amount
     * @param _received: payment status (received or not)
     */
    function addPaymentStatus(
        address _address,
        uint _amount,
        bool _received
    ) public {
        paymentStatus[_address][_amount] = _received;
    }

    /**
     * Remove payment status from the nested mapping
     *
     * @param _address: address we want to remove
     * @param _amount: payment amount we want to remove
     */
    function removePaymentStatus(address _address, uint _amount) public {
        delete paymentStatus[_address][_amount];
    }

    /**
     * Add client
     *
     * @param _address: sender address
     * @param _name: sender name
     * @param _age: sender age
     * @param _amount: payment amount
     */
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

    /**
     * Add new payment data to the array
     *
     * @param _amount: payment amount
     */
    function addNewPayment(uint _amount) public {
        paymentsArray.push(Payment(_amount, block.timestamp));
    }

    /**
     * Receive payments
     */
    function pay() public payable {
        require(msg.value >= 2 ether, "It's too small! I need at least 2 ETH");

        paymentsMessages[msg.sender] = string(
            abi.encodePacked(
                "We received from this address: ",
                uintToString(msg.value, false),
                " Wei"
            )
        );
    }
}
