// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

error HaikuNotUnique();
error NotYourHaiku(uint _id);
error NoHaikusShared();

contract HaikuNFT is ERC721 {
    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] public haikus;

    mapping(address => mapping(uint256 => bool)) public sharedHaikus;

    uint public counter;

    constructor() ERC721("HaikuNFT", "HKUNFT") {
        // "deleted" values return to their default value, which is 0 for numbers
        // Start counting from 1 to avoid security risks as suggested by Base Camp
        counter = 1;
    }

    function mintHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) public {
        // Validate haiku uniqueness
        _validateHaikuUniqueness(_line1, _line2, _line3);
        // Mint the haiku NFT
        _safeMint(msg.sender, counter);
        haikus.push(Haiku(msg.sender, _line1, _line2, _line3));
        counter++;
    }

    function shareHaiku(uint256 _id, address _to) public {
        Haiku memory haikuToShare = haikus[_id - 1];
        if (haikuToShare.author != msg.sender) {
            revert NotYourHaiku(_id);
        }
        sharedHaikus[_to][_id] = true;
    }

    function getMySharedHaikus() public view returns (Haiku[] memory) {
        uint256 sharedHaikusCount;
        for (uint256 i = 0; i < haikus.length; i++) {
            if (sharedHaikus[msg.sender][i + 1]) {
                sharedHaikusCount++;
            }
        }

        Haiku[] memory result = new Haiku[](sharedHaikusCount);
        uint256 idx;
        for (uint256 i = 0; i < haikus.length; i++) {
            if (sharedHaikus[msg.sender][i + 1]) {
                result[idx] = haikus[i];
                idx++;
            }
        }

        if (sharedHaikusCount == 0) {
            revert NoHaikusShared();
        }

        return result;
    }

    function _validateHaikuUniqueness(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) internal view {
        string[3] memory haikusStrings = [_line1, _line2, _line3];
        // > Iterate all lines
        for (uint256 li = 0; li < haikusStrings.length; li++) {
            string memory newLine = haikusStrings[li];
            // > Iterate each Haiku
            for (uint256 i = 0; i < haikus.length; i++) {
                Haiku memory existingHaiku = haikus[i];
                string[3] memory existingHaikuStrings = [
                    existingHaiku.line1,
                    existingHaiku.line2,
                    existingHaiku.line3
                ];

                // > Iterate each line in existing Haiku
                for (uint256 j = 0; j < haikusStrings.length; j++) {
                    string memory existingHaikuString = existingHaikuStrings[j];
                    // > Compare hashes to check whether both strings are identical
                    if (
                        keccak256(abi.encodePacked(existingHaikuString)) ==
                        keccak256(abi.encodePacked(newLine))
                    ) {
                        revert HaikuNotUnique();
                    }
                }
            }
        }
    }
}
