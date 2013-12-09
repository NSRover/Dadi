//
//  DDVertex.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDVertex : NSObject

@property (nonatomic, assign) unsigned int ID;
@property (nonatomic, strong) NSArray* neighbours;

@end
