// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

error NotApproved(string _submittedName);

contract FavoriteRecords {
    mapping(string => bool) public approvedRecords;
    // Nested mappings are also possible!
    mapping(address => mapping(string => bool)) userFavorites;
    string[] recordNames = [
        "Thriller",
        "Back in Black",
        "The Bodyguard",
        "The Dark Side of the Moon",
        "Their Greatest Hits (1971-1975)",
        "Hotel California",
        "Come On Over",
        "Rumours",
        "Saturday Night Fever"
    ];

    constructor() {
        for (uint8 i = 0; i < recordNames.length; i++) {
            approvedRecords[recordNames[i]] = true;
        }
    }

    function getApprovedRecords() external view returns (string[] memory) {
        return recordNames;
    }

    function addRecord(string memory _albumName) external {
        if (approvedRecords[_albumName]) {
            userFavorites[msg.sender][_albumName] = true;
        } else {
            revert NotApproved(_albumName);
        }
    }

    function getUserFavorites(
        address _address
    ) external view returns (string[] memory resultingList) {
        uint8 countOfResultingArrLen = 0;

        // TODO: Is there a way to optimize this shit?
        // First pass to count resulting arr size to avoid assertion errors with [,,,,,,"Thriller"]
        for (uint8 i = 0; i < recordNames.length; i++) {
            if (userFavorites[_address][recordNames[i]]) {
                countOfResultingArrLen++;
            }
        }

        resultingList = new string[](countOfResultingArrLen);

        // Second pass to fill resulting arr
        uint8 cursor = 0;
        for (uint8 i = 0; i < recordNames.length; i++) {
            if (userFavorites[_address][recordNames[i]]) {
                resultingList[cursor] = recordNames[i];
                cursor++;
            }
        }

        return resultingList;
    }

    function resetUserFavorites() external {
        for (uint8 i = 0; i < recordNames.length; i++) {
            if (userFavorites[msg.sender][recordNames[i]]) {
                userFavorites[msg.sender][recordNames[i]] = false;
            }
        }
    }
}
