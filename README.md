 Ethereum 2.0 Final Exam – Smart Contract Project

 👨‍🎓 Exam Submission
This repository contains the smart contracts developed for the Ethereum 2.0 Development Specialization Program Final Exam.

 📂 Project Structure
**  `Voting.sol`**
A Solidity smart contract that implements a basic decentralized voting system.

**Features:**
-	Only contract owner can propose candidates.
-	Each address can vote only once.
-	Votes are tracked per candidate.
-	`getWinners()` returns the winning candidate(s) (including tie support).

  **`Staking.sol`**
Simulates the Ethereum 2.0 staking behavior.

**Features:**
-	Accepts only 32 ETH deposits.
-	Registers senders as validators.
-	Only validators can call the `validate()` function.
-	Emits events for deposit and validation.

 How to Test (Using Remix IDE)
1. Open [Remix](https://remix.ethereum.org)
2. Create new files:
   - `Voting.sol`
   - `Staking.sol`
3. Paste the contract code from this repository.
4. Compile using Solidity version `^0.8.0`.
5. Deploy and interact:
   - Use Injected Provider or Remix VM
   - Switch between accounts to simulate multiple users



