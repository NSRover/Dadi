//
//  DDDadi.m
//  Dadi
//
//  Created by Work on 10/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDDadi.h"
#import "DDConstants.h"

@implementation DDDadi

#pragma mark Public

- (id)initWithDelegate:(id)delegate;
{
    self = [super init];
    
    self.delegate = delegate;
    
    [self reset];
    
    return self;
}

- (DDPlayer *)playerWithID:(int)playerID;
{
    for (DDPlayer *player in _players) {
        if (player.ID == playerID) {
            return player;
        }
    }
    
    NSLog(@"[E] Player %d not found", playerID);
    
    return nil;
}

- (void)reset;
{
    [self createPlayers];
    [self createBoard];
    
    self.state = GameTurnStateBegin;
    self.currentPlayer = C_PLAYERONE_ID;
    
    [self nextTurn];
        [self nextTurn];
        [self nextTurn];
        [self nextTurn];
        [self nextTurn];
    
}

- (void)nextTurn;
{
    //Toggle player
    if (!(_state == GameTurnStateBegin)) {
        self.currentPlayer = (_currentPlayer + 1) % 2;
    }
}

#pragma private

- (void)createBoard;
{
    self.board = [[DDBoard alloc] initWithGame:self];
}

- (void)createPlayers;
{
    DDPlayer *firstPlayer = [[DDPlayer alloc] initWithID:C_PLAYERONE_ID];
    DDPlayer *secondPlayer = [[DDPlayer alloc] initWithID:C_PLAYERTWO_ID];
    
    self.players = @[firstPlayer, secondPlayer];
}

- (NSString *)description;
{
    return [NSString stringWithFormat:@"Player: %d, Turn-type: %d", _currentPlayer, _state];
}

#pragma mark Functional

- (void)tappedVertexID:(int)vertexID;
{
    if (_state == GameTurnStatePlacement) {
        NSLog(@"[!] Cannot tap vertex in coin placement phase");
        return;
    }
}

- (void)tappedCoinStackForPlayerID:(int)playerID;
{
    if (_state == GameTurnStateMoveCoin)
    {
        NSLog(@"[!] No more coins to place");
    }
    else if (_state == GameTurnStateCoinRemove)
    {
        NSLog(@"[!] Remove an opponent coin first");
    }
    else if (_state == GameTurnStatePlacement)
    {
        
    }
    else
    {
        NSLog(@"[E] Unknown game state!");
    }
}

@end
