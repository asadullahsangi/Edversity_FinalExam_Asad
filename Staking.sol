// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Staking {
    uint public constant STAKE_AMOUNT = 32 ether;
    address public owner;

    mapping(address => bool) public isValidator;

    event Deposited(address indexed validator);
    event Validated(address indexed validator);

    constructor() {
        owner = msg.sender;
    }

    function deposit() public payable {
        require(msg.value == STAKE_AMOUNT, "Deposit must be exactly 32 ETH");
        require(!isValidator[msg.sender], "Already a validator");

        isValidator[msg.sender] = true;
        emit Deposited(msg.sender);
    }

    function validate() public {
        require(isValidator[msg.sender], "Only validators can validate");

        emit Validated(msg.sender);
    }
}
