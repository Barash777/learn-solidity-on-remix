// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    // Enum
    enum Status {
        Paid,
        Delivered,
        Received
    }
    Status public currentStatus;

    function paid() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    // Array
    // Fixed size:
    uint[3][2] public items;

    function fixedSize() public {
        items = [[3, 4, 5], [6, 7, 8]];
    }

    // Dynamic
    uint[] public dItems;
    uint public len;

    function dynArr() public {
        dItems.push(4);
        dItems.push(5);
        len = dItems.length;
    }

    function sampleMemory() public pure returns (uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    // Byte
    bytes32 public myVar = "test here"; // fixed
    bytes public myDynVar = "test here"; // dynamic

    // 1 --> 32
    // 32 * 8 = 256
    // uint256

    function firstByte() public view returns (bytes1) {
        return myDynVar[0];
    }

    // Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function getPayment(
        address _addr,
        uint _index
    ) public view returns (Payment memory) {
        return balances[_addr].payments[_index];
    }

    function pay(string memory message) public payable {
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

        balances[msg.sender].payments[paymentNum] = newPayment;
    }
}
