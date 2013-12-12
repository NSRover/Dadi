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

- (BOOL)placeCoinOnVertexID:(int)vertexID;
{
    DDVertex* vertex = [_verticesManager vertexForID:vertexID];
    if (vertex.coin) {
        NSLog(@"[!] There is already a coin there foo!");
        return NO;
    }
    else
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
    return YES;
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
