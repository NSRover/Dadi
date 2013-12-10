//
//  DDCoinManager.m
//  Dadi
//
//  Created by Work on 09/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDCoinManager.h"
#import "DDBoard.h"
#import "DDConstants.h"
#import "DDCoin.h"
#import "DDDadi.h"

@interface DDCoinManager ()

@property (nonatomic, weak) DDBoard *board;

@end

@implementation DDCoinManager

- (id)initWithBoard:(DDBoard *)board;
{
    self = [super init];
    
    self.board = board;
    
    [self reset];
    
    return self;
}

- (void)reset;
{
    [self createCoins];
    [self connectCoins];
}

- (UIView *)coinStackViewForPlayerID:(int)playerID;
{
    UIView *viewToReturn;
    if ([_board.game.delegate respondsToSelector:@selector(coinStackViewForPlayer:)]) {
        viewToReturn = [_board.game.delegate coinStackViewForPlayer:playerID];
    }
    
    if (!viewToReturn) {
        NSLog(@"[E] No coin stack view provided");
    }
    
    return viewToReturn;
}

- (void)createCoins;
{
    NSMutableArray *coinArray = [[NSMutableArray alloc] initWithCapacity:(C_TOTAL_COINS * 2)];
    
    for (int ii = 0; ii < (C_TOTAL_COINS * 2); ii++) {
        DDCoin *coin = [[DDCoin alloc] init];
        coin.ID = ii;
        
        [coinArray addObject:coin];
    }
    
    self.coins = coinArray;
}

- (void)connectCoins;
{    
    for (int ii = 0; ii < (C_TOTAL_COINS * 2); ii++) {
        DDCoin *coin = [_coins objectAtIndex:ii];
        
        UIView* coinStack;
        DDPlayer* player;
        //Assign to player
        if (ii < C_TOTAL_COINS) {
            coin.playerID = C_PLAYERONE_ID;
            coinStack = [self coinStackViewForPlayerID:C_PLAYERONE_ID];
            player = [_board.game playerWithID:C_PLAYERONE_ID];
        }
        else
        {
            coin.playerID = C_PLAYERTWO_ID;
            coinStack = [self coinStackViewForPlayerID:C_PLAYERTWO_ID];
            player = [_board.game playerWithID:C_PLAYERTWO_ID];
        }
        
        //Give view
        coin.view = [[UIImageView alloc] initWithImage:player.playerImage];
        
        //Place on board
        [coin.view setCenter:CGPointMake(coin.view.frame.size.width / 2 * (ii % C_TOTAL_COINS) + coin.view.frame.size.width / 2, coin.view.frame.size.height / 2)];
        [coinStack addSubview:coin.view];
    }
}


@end
