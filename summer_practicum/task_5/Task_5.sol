// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    int number;

    function incByOne() public virtual {
        number++;
    }

    function decByOne() public virtual {
        number--;
    }

    function callChangeOwner(
        address _contractAddress,
        address _newOwner
    ) external {
        (bool success, ) = _contractAddress.call(
            abi.encodeWithSignature("changeOwner(address)", _newOwner)
        );

        require(success, "can't set new owner!");
    }
}

contract B is A {
    event NumberChanged(int _newValue);

    function incByAnyNumber(int _value) public {
        number += _value;
        emit NumberChanged(number);
    }

    function decByAnyNumber(int _value) public {
        number -= _value;
        emit NumberChanged(number);
    }

    function incByOne() public override {
        super.incByOne();
        emit NumberChanged(number);
    }

    function decByOne() public override {
        super.decByOne();
        emit NumberChanged(number);
    }
}

contract C is B {
    address public owner;

    function changeOwner(address _newAddress) public {
        owner = _newAddress;
    }
}
