//
//  DDDadi.h
//  Dadi
//
//  Created by Work on 10/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDBoard.h"
#import "DDPlayer.h"
#import "DDConstants.h"
#import "DDVertex.h"

//Protocol
@protocol DDDadiDelegate <NSObject>

//Views
- (UIView *)viewForVerticeIndex:(int)vertexIndex;
- (UIView *)coinStackViewForPlayer:(int)playerID;
- (void)addCoinView:(UIView *)view coinIndex:(int)coinIndex playerID:(int)playerID;

@end

@interface DDDadi : NSObject

@property (nonatomic, strong) id <DDDadiDelegate> delegate;
@property (nonatomic, strong) DDBoard *board;
@property (nonatomic, strong) NSArray *players;

@property (nonatomic, assign) GameTurnState state;
@property (nonatomic, assign) int currentPlayer;

- (id)initWithDelegate:(id)delegate;
- (DDPlayer *)playerWithID:(int)playerID;

#pragma mark Functional

- (void)nextTurn;

- (void)tappedVertexID:(int)vertexID;
- (void)tappedCoinStackForPlayerID:(int)playerID;

@end
