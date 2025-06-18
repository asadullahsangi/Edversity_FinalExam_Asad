// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Staking {
    // Fixed staking amount required (32 ETH)
    uint public constant STAKE_AMOUNT = 32 ether;
    address public owner;

    // Mapping to track validator addresses
    mapping(address => bool) public isValidator;

    // Events to log deposit and validation actions
    event Deposited(address indexed validator);
    event Validated(address indexed validator);

    // Constructor sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Allows users to become validators by depositing 32 ETH
    function deposit() public payable {
        require(msg.value == STAKE_AMOUNT, "Deposit must be exactly 32 ETH");
        require(!isValidator[msg.sender], "Already a validator");

        isValidator[msg.sender] = true;
        emit Deposited(msg.sender);
    }

    // Allows only validators to simulate a validation action
    function validate() public {
        require(isValidator[msg.sender], "Only validators can validate");

        emit Validated(msg.sender);
    }
}
