// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Coin Flip
 * @dev Anshuman(+91-8287407339)
 */

contract CoinFlip {
    int SIZE  = 5;  // Maximum number of users
    struct betDetails{
        bool guess;
        int amount;
        bool flag;
    }

    mapping(int => int) userBalance; // For user's balance
    mapping(int => betDetails) userBets;

    // Initialize all user with 100 points
    function initializeUser() public{
        for(int i=0; i<SIZE; i++){
            userBalance[i] = 100;
        }
    }

    // Return User's Balance using userId
    function displayUserBalance(int userId) public view returns(int){
        if(userId>=0 && userId<SIZE)
            return userBalance[userId];
        else return -1;
    }

    
    function placeBet(int userId, int amount, bool guess) public returns(bool){
        if(userId<0 || userId>=SIZE) // for Invalid ID
            return false;
        if(userBalance[userId]<amount) // for low balance
            return false;
        if(userBets[userId].flag) // for already participated into bet game
            return false;

        // Deduct the user's balance
        userBalance[userId] -= amount;
        // Add their bet
        userBets[userId].amount = amount;
        userBets[userId].guess = guess;
        userBets[userId].flag = true;

        return true;       
    }

    // Return the random number in range [0,mod-1]
    function randModules(uint mod) public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % mod;
    }

    // Conclude all bets with win/loss
    function rewardBet() public {
        bool coinResult = true;
        uint randNumber = randModules(1000000007);
        if(randNumber%2 == 0)
            coinResult = true;
        else 
            coinResult = false;
            
        // Check all the result
        for(int i=0; i<SIZE; i++){
            if(userBets[i].flag && userBets[i].guess == coinResult){
                userBalance[i] += (2*userBets[i].amount);
                userBets[i].flag = false;
            }
        }
    }

}