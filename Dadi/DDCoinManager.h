//
//  DDCoinManager.h
//  Dadi
//
//  Created by Work on 09/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDBoard;
@class DDCoin;
@class DDVertex;

@interface DDCoinManager : NSObject

@property (nonatomic, strong) NSArray *coins;
@property (nonatomic, strong) DDCoin *selectedCoin;

- (id)initWithBoard:(DDBoard *)board;
- (void)reset;

#pragma mark Functional

- (DDCoin *)topCoinInStack;
- (BOOL)selectCoinInStack;
- (void)selectCoinOnVertex:(DDVertex *)vertex;
- (void)moveCoinToVertex:(DDVertex *)vertex;
- (void)moveRemovedCoinToStackView:(UIView *)stackView;
- (void)deselectCoin;
- (void)detachFromCurrentVertex;

@end
