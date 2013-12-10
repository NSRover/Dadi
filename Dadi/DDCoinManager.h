//
//  DDCoinManager.h
//  Dadi
//
//  Created by Work on 09/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDBoard;

@interface DDCoinManager : NSObject

@property (nonatomic, strong) NSArray *coins;

- (id)initWithBoard:(DDBoard *)board;
- (void)reset;

@end
