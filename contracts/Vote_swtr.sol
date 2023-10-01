// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract VotingSystem {
    address public owner; // Contract owner's address
    uint256 public totalVotes; // Total votes cast
    
    // Mapping to store the registered voters
    mapping(address => bool) private registeredVoters;
    
    // Mapping to store the votes for each candidate
    mapping(string => uint256) private candidateVotes;
    
    // Event to log when a new voter is registered
    event VoterRegistered(address indexed voter);
    
    // Event to log when a vote is cast
    event VoteCast(address indexed voter, string candidate);
    
    // Modifier to check if the caller is the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    // Modifier to check if the caller is a registered voter
    modifier onlyVoter() {
        require(registeredVoters[msg.sender], "Only registered voters can interact with this function");
        _;
    }
    
    constructor() {
        owner = msg.sender; // Set the contract owner to the deployer's address
    }
    
    // Function for the contract owner to register new voters
    function registerVoter(address _voterAddress) public onlyOwner {
        registeredVoters[_voterAddress] = true;
        emit VoterRegistered(_voterAddress);
    }
    
    // Function for registered voters to cast their votes
    function vote(string memory _candidate) public onlyVoter {
        candidateVotes[_candidate] += 1;
        totalVotes += 1;
        emit VoteCast(msg.sender, _candidate);
    }
    
    // Function to retrieve the current vote count for a candidate
    function getVoteCount(string memory _candidate) public view returns (uint256) {
        return candidateVotes[_candidate];
    }
}
