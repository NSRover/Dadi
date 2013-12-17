//
//  DDDadi.m
//  Dadi
//
//  Created by Work on 10/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDDadi.h"
#import "DDConstants.h"

@interface DDDadi ()

@property (assign, nonatomic) BOOL millFormed;

@end

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
}

- (void)nextTurn;
{
    //Check if first turn
    if (_state == GameTurnStateBegin) {
        self.state = GameTurnStateSelectCoin;
        return;
    }
    
    //Toggle turn
    self.currentPlayer = (_currentPlayer + 1) % 2;

    self.state = GameTurnStateSelectCoin;
}

- (void)turnComplete;
{
    //check mill and stuff
    [self nextTurn];
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

#pragma mark Game progress

- (void)coinSelected;
{
    //Change state
    self.state = GameTurnStatePlacement;
}

- (void)coinPlacedAtVertexID:(int)vertexID;
{
    //check if mill is formed
    if ([_board isMillFormedForVertexID:vertexID])
    {
        self.state = GameTurnStateCoinRemove;
        NSLog(@"[!] Mill formed, remove other player's coin!");
    }
    //If not change game state and toggle turn
    else
    {
        [self turnComplete];
    }
}

- (void)coinRemovedFromVertexID:(int)vertexID;
{
    //Check if enough coins are available to continue game
    
    //end turn
    [self turnComplete];
}

#pragma mark Functional

- (void)tappedVertexID:(int)vertexID;
{
    if (_state == GameTurnStateSelectCoin)
    {
        if ([_board coinsAvailableInStackForCurrentPlayer])
        {
            NSLog(@"[!] Cannot tap vertex while you still have coins in stack!");
        }
        else
        {
            if ([_board currentPlayerCanSelectCoinOnVertexID:vertexID])
            {
                [_board selectCoinOnVertexID:vertexID];
                [self coinSelected];
            }
            else
            {
                NSLog(@"[!] Can't you just select your coin?");
            }
        }

        return;
    }
    else if (_state == GameTurnStatePlacement)
    {
        if ([_board placeCoinOnVertexID:vertexID])
        {
            [self coinPlacedAtVertexID:vertexID];
        }
        else
        {
            NSLog(@"[!] To unselect a coin, tap outside.");
        }
    }
    else if (_state == GameTurnStateCoinRemove)
    {
        if ([_board didRemoveCoinOnVertexID:vertexID])
        {
            [self coinRemovedFromVertexID:vertexID];
        }
    }
    else if (_state == GameTurnStatePlacement)
    {
        
    }
    else
    {
        NSLog(@"[!] You broke the damn game foo! start over!");
    }
}

- (void)tappedOutSide;
{
    if (_state == GameTurnStatePlacement) {
        [_board.coinManager deselectCoin];
        self.state = GameTurnStateSelectCoin;
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
    else if (_state == GameTurnStateSelectCoin)
    {
        if (playerID == _currentPlayer)
        {
            if ([_board selectCoinInStack])
            {
                [self coinSelected];
            };
            
        }
        else
        {
            NSLog(@"[!] Dont touch others stack man!");
        }

    }
    else if (_state == GameTurnStatePlacement)
    {
        NSLog(@"[!] Place the one you already have first");
    }
    else
    {
        NSLog(@"[E] Unknown game state!");
    }
}

@end
