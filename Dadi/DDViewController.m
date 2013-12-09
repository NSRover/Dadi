//
//  DDViewController.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDViewController.h"
#import "DDBoard.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    DDBoard *board = [[DDBoard alloc] init];
    
    NSLog(@"%d", self.verticesView.subviews.count);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
