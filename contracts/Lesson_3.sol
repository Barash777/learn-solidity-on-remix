// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
	// STRINGS
	string public myStr = "test"; // storage

    function demo(string memory newValueStr) public {
        // string memory myTempStr = "temp";
        myStr = newValueStr;
    }
		
	// ADDRESSES
	address public myAddr = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
		
	function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable(targetAddr);
        _to.transfer(amount);
    }

    function getBalance(address targetAddr) public view returns(uint) {
        return targetAddr.balance;
    }
		
    mapping (address => uint) public payments; // storage

    function receiveFunds() public payable {
        payments[msg.sender] = msg.value;
    }
}