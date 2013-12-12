//
//  DDConstants.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 28/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#define C_TOTAL_VERTICES 24

#define C_NEIGHBOURHOOD @"0:1,9|1:0,4,2|2:1,4|3:4,10|4:1,3,5,7|5:4,13|6:7,11|7:4,6,8|8:7,12|9:0,10,21|10:3,9,11,18|11:6,10,15|12:8,13,17|13:5,12,14,20|14:2,13,23|15:11,16|16:15,17,19|17:12,16|18:10,19|19:16,18,19,20|20:13,19|21:9,22|22:19,21,23|23:14,22"

#define C_TOTAL_COINS 9

#define C_PLAYERONE_ID 0
#define C_PLAYERTWO_ID 1

typedef enum
{
    GameTurnStateBegin = 0,
    GameTurnStateSelectCoin,
    GameTurnStatePlacement,
    GameTurnStateCoinRemove,
    GameTurnStateMoveCoin
}
GameTurnState;

typedef enum
{
    CoinStateUndefined = 0,
    CoinStateInStack,
    CoinStateOnVertice,
    CoinStateRemoved
}
CoinState;

//View constants
#define A_COINPLACE_DURATION 0.5