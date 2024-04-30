// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract ArraysExercise {
    uint internal constant Y2K_UNIX_TS = 946702800;

    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    address[] public senders;
    uint[] public timestamps;

    function getNumbers() public view returns (uint[] memory numbersArr) {
        return numbers;
    }

    function resetNumbers() public {
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    }

    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    function afterY2K()
        public
        view
        returns (
            uint[] memory resultingTimetamps,
            address[] memory resultingSenders
        )
    {
        uint arrSize = _countY2KTimestamps();
        uint[] memory y2kTimestamps = new uint[](arrSize);
        address[] memory y2kSenders = new address[](arrSize);

        uint cursor = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K_UNIX_TS) {
                y2kTimestamps[cursor] = timestamps[i];
                y2kSenders[cursor] = senders[i];
                cursor++;
            }
        }

        return (y2kTimestamps, y2kSenders);
    }

    function resetTimestamps() public {
        delete timestamps;
    }

    function resetSenders() public {
        delete senders;
    }

    function _countY2KTimestamps() internal view returns (uint) {
        uint result = 0;

        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > Y2K_UNIX_TS) {
                result++;
            }
        }

        return result;
    }
}
