//
//  DDVertex.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DDCoin;

@interface DDVertex : NSObject

@property (nonatomic, assign) unsigned int ID;
@property (nonatomic, assign) unsigned int row;
@property (nonatomic, assign) unsigned int coloumn;

@property (nonatomic, strong) NSArray *neighbours;
@property (nonatomic, strong) UIView *view;

@property (weak, nonatomic) DDCoin* coin;

@end
