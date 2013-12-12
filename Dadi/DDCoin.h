//
//  DDCoin.h
//  Dadi
//
//  Created by Work on 09/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDCoinView.h"
#import "DDConstants.h"
@class DDVertex;

@interface DDCoin : NSObject

@property (nonatomic, assign) unsigned int ID;
@property (nonatomic, assign) unsigned int playerID;
@property (nonatomic, strong) DDCoinView *view;
@property (assign, nonatomic) CoinState state;
@property (weak, nonatomic) DDVertex* vertex;

@end
