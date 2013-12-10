//
//  DDViewController.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDViewController.h"
#import "DDDadi.h"
#import "DDConstants.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.game = [[DDDadi alloc] initWithDelegate:self];
    
    [self configureTouch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Touch

- (void)configureTouch;
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)userTapped:(id)sender;
{
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    
    CGPoint touchLocation = [tapGestureRecognizer locationInView:self.view];
    
    //Top Coin stack
    if (CGRectContainsPoint(_playerOneCoinStack.frame, touchLocation)) {
        [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
    }
    else if (CGRectContainsPoint(_playerTwoCoinStack.frame, touchLocation))
    {
        [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
    }
    else
    {
        for (UIView* verticeView in [_verticesView subviews]) {
            if (CGRectContainsPoint(verticeView.frame, touchLocation)) {
                [_game tappedVertexID:verticeView.tag];
            }
        }
    }
}

#pragma mark DDBoardDelegate

- (UIView *)viewForVerticeIndex:(int)vertexIndex;
{
    UIView* requiredView = [self.verticesView.subviews objectAtIndex:vertexIndex];
    return requiredView;
}

- (UIView *)coinStackViewForPlayer:(int)playerID;
{
    UIView* viewToReturn = nil;
    if (playerID == C_PLAYERONE_ID)
    {
        viewToReturn = _playerOneCoinStack;
    }
    else
    {
        viewToReturn = _playerTwoCoinStack;
    }
    return viewToReturn;
}

@end
