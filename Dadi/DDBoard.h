//
//  DDBoard.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDVerticesManager.h"
#import "DDCoinManager.h"
@class DDDadi;

@interface DDBoard : NSObject

@property (nonatomic, weak) DDDadi *game;
@property (nonatomic, strong) DDVerticesManager *verticesManager;
@property (nonatomic, strong) DDCoinManager *coinManager;

- (id)initWithGame:(DDDadi *)game;

- (BOOL)selectCoinInStack;
- (BOOL)placeCoinOnVertexID:(int)vertexID;

@end
