// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    address public owner;

    // Struct to hold candidate data
    struct Candidate {
        string name;
        uint voteCount;
    }

    // Mapping to track if an address has voted
    mapping(address => bool) public hasVoted;

    // Dynamic array of candidates
    Candidate[] public candidates;

    // Contract constructor sets the deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to owner-only functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // Allows the owner to propose a new candidate
    function proposeCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate(_name, 0));
    }

    // Allows users to vote for a candidate by index
    function vote(uint candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
    }

    // Returns the list of all candidates
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Returns the vote count for a specific candidate by name
    function getCandidateByName(string memory name) public view returns (uint) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(name))) {
                return candidates[i].voteCount;
            }
        }
        revert("Candidate not found");
    }

    // Returns the index of the winning candidate
    function getWinner() public view returns (uint winnerIndex) {
        uint maxVotes = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }
    }
}
