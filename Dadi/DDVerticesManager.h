//
//  DDVerticeManager.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDBoard;
@class DDVertex;

@interface DDVerticesManager : NSObject

@property (nonatomic, strong) NSArray *vertices;

- (id)initWithBoard:(DDBoard *)board;
- (void)reset;

- (DDVertex *)vertexForID:(int)index;

- (BOOL)placeCoinOnVertex:(DDVertex *)vertex;

@end
