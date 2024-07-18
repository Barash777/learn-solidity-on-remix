// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library LibraryStrExt {
    function eq(
        string memory str1,
        string memory str2
    ) internal pure returns (bool) {
        return keccak256(abi.encode(str1)) == keccak256(abi.encode(str2));
    }
}

library LibraryArrayExt {
    function inArray(
        uint[] memory array,
        uint element
    ) internal pure returns (bool) {
        for (uint i = 0; i < array.length; i++) {
            if (element == array[i]) {
                return true;
            }
        }

        return false;
    }
}
