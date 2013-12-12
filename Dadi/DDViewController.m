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
#import "DDVertex.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.game = [[DDDadi alloc] initWithDelegate:self];
    
    [self configureTouch];
    [_game nextTurn];
    
    for (UIView *vertice in _verticesView.subviews) {
        int tag = vertice.tag;
        if (tag == 0)
        {
            continue;
        }
        
//        NSLog(@"%@ - %@ - %d", NSStringFromCGPoint(vertice.center), NSStringFromCGPoint([self.view convertPoint:vertice.center fromView:self.verticesView]), vertice.tag);
    }
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
        for (UIView* verticeView in [_verticesView subviews])
        {
            if (CGRectContainsPoint(verticeView.frame, touchLocation))
            {
                [_game tappedVertexID:(verticeView.tag + 0)];
            }
        }
    }
}

#pragma mark DDBoardDelegate

- (UIView *)viewForVerticeIndex:(int)vertexIndex;
{
    for (UIView* vertex in _verticesView.subviews)
    {
        if (vertex.tag == vertexIndex) {
            return vertex;
        }
    }
    return nil;
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

- (void)addCoinView:(UIView *)view coinIndex:(int)coinIndex playerID:(int)playerID;
{
    CGPoint stackStart;
    if (playerID == C_PLAYERONE_ID) {
        stackStart = _playerOneCoinStack.frame.origin;
    }
    else
    {
        stackStart = _playerTwoCoinStack.frame.origin;
    }
    
    [view setCenter:CGPointMake(view.frame.size.width / 2 * coinIndex + view.frame.size.width / 2, stackStart.y + view.frame.size.height / 2)];
    
    [self.view addSubview:view];
}

@end
