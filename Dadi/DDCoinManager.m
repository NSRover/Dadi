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
#import "DDVertex.h"

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
        coin.state = CoinStateUndefined;
        
        [coinArray addObject:coin];
    }
    
    self.coins = coinArray;
}

- (void)connectCoins;
{
    for (int ii = 0; ii < (C_TOTAL_COINS * 2); ii++) {
        DDCoin *coin = [_coins objectAtIndex:ii];
        coin.state = CoinStateInStack;
        
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
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DDCoinView" owner:self options:nil];
        coin.view = [array objectAtIndex:0];
        coin.view.imageView.image = player.playerImage;
        
        //Place on board
        if ([_board.game.delegate respondsToSelector:@selector(addCoinView:coinIndex:playerID:)]) {
            [_board.game.delegate addCoinView:coin.view coinIndex:(ii % C_TOTAL_COINS) playerID:coin.playerID];
        }
    }
}

#pragma mark Functional

- (DDCoin *)topCoinInStack;
{
    DDCoin* coinToSelect;
    for (DDCoin *coin in _coins) {
        if (coin.playerID == _board.game.currentPlayer && coin.state == CoinStateInStack)
        {
            if (!coinToSelect || coin.ID > coinToSelect.ID) {
                coinToSelect = coin;
            }
        }
    }
    return coinToSelect;
}

- (BOOL)selectCoinInStack;
{
    DDCoin* coinToSelect = [self topCoinInStack];
    
    if (coinToSelect) {
        self.selectedCoin = coinToSelect;
        [_selectedCoin.view.imageView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.4]];
        return YES;
    }
    
    return NO;
}

- (void)moveCoinToVertex:(DDVertex *)vertex;
{
    DDCoin* coin = _selectedCoin;
    
    [UIView animateWithDuration:A_COINPLACE_DURATION animations:^(void)
    {
        coin.view.center = vertex.view.center;
    } completion:^(BOOL done)
    {
        coin.vertex = vertex;
        coin.state = CoinStateOnVertice;
    }];
}

- (void)moveRemovedCoinToStackView:(UIView *)stackView;
{
    DDCoin* coin = _selectedCoin;
    coin.vertex = nil;
    coin.state = CoinStateRemoved;
    
    [UIView animateWithDuration:A_COINPLACE_DURATION animations:^(void)
     {
         //Calculate position
         CGPoint startPoint = CGPointMake(stackView.center.x + stackView.frame.size.width / 2, stackView.center.y);
         int numberOfStackCoins = 0;
         for (DDCoin *candidate in _coins) {
             if (candidate.state == CoinStateRemoved && candidate.playerID != _board.game.currentPlayer) {
                 numberOfStackCoins++;
             }
         }
         
         CGPoint finalPoint = CGPointMake((startPoint.x - coin.view.frame.size.width / 2) - numberOfStackCoins * (coin.view.frame.size.width / 2), startPoint.y);
         coin.view.center = finalPoint;
         [coin.view.imageView setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.4]];
     }];
}

- (void)deselectCoin;
{
    [UIView animateWithDuration:A_COINPLACE_DURATION animations:^(void)
     {
         [_selectedCoin.view.imageView setBackgroundColor:[UIColor clearColor]];
     }];
    
    self.selectedCoin = nil;
}

@end
