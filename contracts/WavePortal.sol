// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    // We will be using this below to help generate a random number
    uint256 private seed;

    /**
        event : Event is an inheritable member of a contract. An event is emitted, it stores the arguments 
        passed in transaction logs. These logs are stored on blockchain and are accessible using address of 
        the contract till the contract is present on the blockchain.
     */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
        I created a struct here named Wave.
        A struct is basically a custom datatype where we can customize what we want to hold inside it.
     */
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    Wave[] waves;

    /**
        This is an address => uint mapping, meaning I can associate an address with a number!
        In this case, I'llbe storing the address with the last time the user waved at us.
    */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Intelligent contract constructed");

        // Initialize seed
        seed = (block.prevrandao + block.timestamp) % 100;
    }

    function wave(string memory _message) public {
        // We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp stored
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Must wait 30 seconds before waving again."
        );

        // Update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved /w message : %s", msg.sender, _message);

        /*
            This is where I actually store the wave data in the array.
         */
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // Generate a new seed for the next user that sends a wave
        seed = (block.prevrandao + block.timestamp + seed) % 100;

        console.log("Random # generated : %d ", seed);

        // Give a 50% chance that the user wins the prize

        if (seed <= 50) {
            console.log("%s won !", seed);

            uint256 prizeAmount = 0.0001 ether;

            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );

            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from the contract.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}
