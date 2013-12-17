//
//  DDConstants.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 28/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#define C_TOTAL_VERTICES 24

#define C_NEIGHBOURHOOD @"0-0,0:1,9|1-0,3:0,4,2|2-0,6:1,4|3-1,1:4,10|4-1,3:1,3,5,7|5-1,5:4,13|6-2,2:7,11|7-2,3:4,6,8|8-2,4:7,12|9-3,0:0,10,21|10-3,1:3,9,11,18|11-3,2:6,10,15|12-3,4:8,13,17|13-3,5:5,12,14,20|14-3,6:2,13,23|15-4,2:11,16|16-4,3:15,17,19|17-4,4:12,16|18-5,1:10,19|19-5,3:16,18,19,20|20-5,4:13,19|21-6,0:9,22|22-6,3:19,21,23|23-6,6:14,22"

#define C_TOTAL_COINS 9

#define C_PLAYERONE_ID 0
#define C_PLAYERTWO_ID 1

#define C_PLAYERONE_STACKINDEX 25
#define C_PLAYERTWO_STACKINDEX 26

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

typedef enum
{
    NeighbourDirectionHorizontal = 0,
    NeighbourDirectionVertical
}
NeighbourDirection;

//View constants
#define A_COINPLACE_DURATION 0.5