// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    address public owner;

    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    function proposeCandidate(string memory _name) public onlyOwner {
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint candidateIndex) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        hasVoted[msg.sender] = true;
        candidates[candidateIndex].voteCount += 1;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }
    function getCandidateByName(string memory name) public view returns (uint index, uint voteCount) {
    for (uint i = 0; i < candidates.length; i++) {
        if (keccak256(bytes(candidates[i].name)) == keccak256(bytes(name))) {
            return (i, candidates[i].voteCount);
        }
    }
    revert("Candidate not found");
    }
    function getWinners() public view returns (string[] memory winnerNames, uint highestVotes) {
    uint maxVotes = 0;
    uint count = 0;

    // First, find the highest vote count
    for (uint i = 0; i < candidates.length; i++) {
        if (candidates[i].voteCount > maxVotes) {
            maxVotes = candidates[i].voteCount;
        }
    }

    // Count how many candidates have maxVotes
    for (uint i = 0; i < candidates.length; i++) {
        if (candidates[i].voteCount == maxVotes) {
            count++;
        }
    }

    // Create result arrays
    winnerNames = new string[](count);
    uint index = 0;

    for (uint i = 0; i < candidates.length; i++) {
        if (candidates[i].voteCount == maxVotes) {
            winnerNames[index] = candidates[i].name;
            index++;
        }
    }

    return (winnerNames, maxVotes);
}

}
