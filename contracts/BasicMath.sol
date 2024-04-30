// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract BasicMath {
    function adder(
        uint _a,
        uint _b
    ) external pure returns (uint sum, bool error) {
        unchecked {
            sum = _a + _b;
            if (sum > _a && sum > _b) {
                return (sum, false);
            }
        }
        return (0, true);
    }

    function subtractor(
        uint _a,
        uint _b
    ) external pure returns (uint difference, bool error) {
        unchecked {
            difference = _a - _b;
            if (difference < _a) {
                return (difference, false);
            }
        }
        return (0, true);
    }
}