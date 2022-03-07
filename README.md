# Solidity_Coin_Flip

## Coin Flip Overview

- Coin Flip Game is to be a smart contract using Harmony VRF function
- Allows a user to place a bet on a particular outcome of a coin flip using a function that accepts amount = integer and bet = 0 or 1 representing heads or tails
    - Store the user’s balance in a mapping. By default, each address gets 100 points free to start.
    - Store the user’s bet in the smart contract using mappings / arrays and structs as seems best
        - Deduct their balance based on the bet amount
        - do not allow a bet more than the balance they have
    - Allow multiple bets to be placed using the same function, i.e., different wallet can interact with the smart contract to place different bets
    - Don’t allow the same contract to place multiple bets if they have an existing undecided bet
- Some time later, another function “rewardBets” is used to generate random num and conclude all bets with win/loss
    - Use VRF to generate a random number and decide heads or tails
    - Go through all bets
        - If win, double the user’s bet amount and add it to their balance (i.e. they got 2x on their money)
        - If loss, no balance to be transferred (as balance already deducted at time of making bet)
        - In either case, conclude the bet by setting a flag or moving the bet to a different mapping “completedBets” which is separate from “ongoingBets”
        - Emit an event containing gambler address and bet amount for every win