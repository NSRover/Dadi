//
//  DDViewController.h
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDDadi.h"

@interface DDViewController : UIViewController <DDDadiDelegate>

@property (nonatomic, strong) DDDadi* game;

@property (weak, nonatomic) IBOutlet UIView *verticesView;
@property (weak, nonatomic) IBOutlet UIView *playerOneCoinStack;
@property (weak, nonatomic) IBOutlet UIView *playerTwoCoinStack;

@end
