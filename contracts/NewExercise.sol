// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./AddressBook.sol";

contract AddressBookFactory {
    string private salt = "060606";
    function deploy() external returns (AddressBook) {
        AddressBook newAddressBook = new AddressBook();
        newAddressBook.transferOwnership(msg.sender);
        return newAddressBook;
    }
}
