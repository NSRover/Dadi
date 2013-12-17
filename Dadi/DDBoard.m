//
//  DDBoard.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDBoard.h"
#import "DDVertex.h"
#import "DDDadi.h"
#import "DDCoin.h"

@implementation DDBoard

#pragma mark Public

- (id)initWithGame:(DDDadi *)game;
{
    self = [super init];
    
    self.game = game;
    
    [self initVerticesManager];
    [self initCoinManager];
    
    return self;
}

- (BOOL)selectCoinInStack;
{
    return [_coinManager selectCoinInStack];
}

- (void)selectCoinOnVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    [_coinManager selectCoinOnVertex:vertex];
}

- (BOOL)placeCoinOnVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    if (vertex.coin) {
        NSLog(@"[!] There is already a coin there foo!");
        return NO;
    }
    else
    {
        //Stack coin - just check if the target vertex already has a coin
        if (_coinManager.selectedCoin.state == CoinStateInStack)
        {
            if (![_verticesManager placeCoinOnVertex:vertex])
            {
                NSLog(@"[!] You cant place a coin there!");
                return NO;
            }
            else
            {
                [_coinManager deselectCoin];
            }
        }
        //If moving from another vertex, we need to check if this is a valid move. i.e. neighbour
        else
        {
            if (vertex.coin) {
                NSLog(@"[!] You cant place a coin there!");
                return NO;
            }
            else
            {
                DDVertex* currentCoinVertex = _coinManager.selectedCoin.vertex;
                BOOL targetVertexIsNeighbour = NO;
                for (DDVertex *candidate in currentCoinVertex.neighbours) {
                    if (candidate == vertex) {
                        targetVertexIsNeighbour = YES;
                        break;
                    }
                }
                
                if (targetVertexIsNeighbour)
                {
                    [_verticesManager placeCoinOnVertex:vertex];
                    [_coinManager deselectCoin];
                }
                else
                {
                    NSLog(@"[!] You can only place your coin on a neighbouring vertex");
                    return NO;
                }
            }
        }
    }
    return YES;
}

#pragma mark Logic

- (BOOL)isMillFormedForVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    
    //Horizontal
    NSArray* allHorizontalNeighbours = [_verticesManager allNeighbourVerticesForVertex:vertex inDirection:NeighbourDirectionHorizontal];
    BOOL horzontalMillFormed = YES;
    for (DDVertex *neighbour in allHorizontalNeighbours)
    {
        if (!neighbour.coin) {
            horzontalMillFormed = NO;
            break;
        }
        else
        {
            if (!(neighbour.coin.playerID == _game.currentPlayer)) {
                horzontalMillFormed = NO;
                break;
            }
        }
    }
    
    if (horzontalMillFormed) {
        return YES;
    }
    
    //check vertical
    
    check if vertical mill formed
    
    return NO;
}

- (BOOL)didRemoveCoinOnVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    
    //Check if vertex contains a valid coin
    if (vertex.coin && vertex.coin.playerID != _game.currentPlayer)
    {
        self.coinManager.selectedCoin = vertex.coin;
        
        //Remove from vertex
        [_verticesManager removeCoinFromVertex:vertex];
        
        //Move coin to opposite stack
        UIView* stackView;
        if (_game.currentPlayer == C_PLAYERONE_ID) {
            stackView = [_game.delegate viewForVerticeIndex:C_PLAYERTWO_STACKINDEX];
        }
        else
        {
            stackView = [_game.delegate viewForVerticeIndex:C_PLAYERONE_STACKINDEX];
        }
        [_coinManager moveRemovedCoinToStackView:stackView];
        [_coinManager deselectCoin];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)coinsAvailableInStackForCurrentPlayer;
{
    if ([_coinManager topCoinInStack]) {
        return YES;
    }
    return NO;
}

- (BOOL)currentPlayerCanSelectCoinOnVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    
    if (vertex.coin && vertex.coin.playerID == _game.currentPlayer) {
        return YES;
    }
    
    return NO;
}

#pragma mark Private

- (void)initVerticesManager;
{
    self.verticesManager = [[DDVerticesManager alloc] initWithBoard:self];
}

- (void)initCoinManager;
{
    self.coinManager = [[DDCoinManager alloc] initWithBoard:self];
}

@end
