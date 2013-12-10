//
//  DDPlayer.h
//  Dadi
//
//  Created by Work on 10/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDPlayer : NSObject

@property (nonatomic, assign) unsigned int ID;
@property (nonatomic, strong) UIImage* playerImage;

- (id)initWithID:(int)playerID;

@end
