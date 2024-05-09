// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku(
        string calldata _string1,
        string calldata _string2,
        string calldata _string3
    ) external {
        haiku.line1 = _string1;
        haiku.line2 = _string2;
        haiku.line3 = _string3;
    }

    function getHaiku() external view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    function shruggieHaiku()
        external
        view
        returns (SillyStringUtils.Haiku memory shuruggiedHaiku)
    {
        shuruggiedHaiku = haiku;
        shuruggiedHaiku.line3 = shuruggiedHaiku.line3.shruggie();
        return shuruggiedHaiku;
    }
}
