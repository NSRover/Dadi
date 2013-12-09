//
//  DDBoard.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDBoard.h"

@implementation DDBoard

- (id)init;
{
    self = [super init];
    
    [self initVerticesManager];
    
    NSLog(@"Vertices Manager %@", [_verticesManager description]);
    
    return self;
}

- (void)initVerticesManager;
{
    self.verticesManager = [[DDVerticesManager alloc] init];
    [_verticesManager reset];
}

@end
