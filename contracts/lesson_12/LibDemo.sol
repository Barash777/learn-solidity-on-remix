// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./LibraryExt.sol";

contract LibDemo {
    using LibraryStrExt for string;
    using LibraryArrayExt for uint[];

    function compareStrings(
        string memory str1,
        string memory str2
    ) public pure returns (bool) {
        return str1.eq(str2);
    }

    function findElement(
        uint[] memory array,
        uint element
    ) public pure returns (bool) {
        return array.inArray(element);
    }
}
