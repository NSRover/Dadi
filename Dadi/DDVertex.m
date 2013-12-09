//
//  DDVertex.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDVertex.h"

@implementation DDVertex

- (NSString *)description;
{
    NSString* string = [NSString stringWithFormat:@"ID: %d", _ID];
    return string;
}

@end
