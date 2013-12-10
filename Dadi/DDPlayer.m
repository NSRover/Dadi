//
//  DDPlayer.m
//  Dadi
//
//  Created by Work on 10/12/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDPlayer.h"
#import "DDConstants.h"

@implementation DDPlayer

- (id)initWithID:(int)playerID;
{
    self = [super init];
    
    self.ID = playerID;
    
    //Player image
    if (playerID == C_PLAYERONE_ID) {
        self.playerImage = [UIImage imageNamed:@"alien_32.png"];
    }
    else
    {
        self.playerImage = [UIImage imageNamed:@"cientifico_loco_32.png"];
    }
    
    return self;
}

@end
