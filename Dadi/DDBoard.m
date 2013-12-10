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

- (id)initWithGame:(DDDadi *)game;
{
    self = [super init];
    
    self.game = game;
    
    [self initVerticesManager];
    [self initCoinManager];
    
    return self;
}

- (void)initVerticesManager;
{
    self.verticesManager = [[DDVerticesManager alloc] initWithBoard:self];
}

- (void)initCoinManager;
{
    self.coinManager = [[DDCoinManager alloc] initWithBoard:self];
}

@end
