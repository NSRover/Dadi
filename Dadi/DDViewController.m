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

#define TURN_INTERVAL 0.1

@interface DDViewController ()

@property (assign, nonatomic) int demoTurn;

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
    }
    
    [self startDemo];
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
    if (CGRectContainsPoint(_playerOneCoinStack.frame, touchLocation))
    {
        [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
    }
    else if (CGRectContainsPoint(_playerTwoCoinStack.frame, touchLocation))
    {
        [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
    }
    else
    {
        BOOL didTapValidVertice = NO;
        for (UIView* verticeView in [_verticesView subviews])
        {
            if (CGRectContainsPoint(verticeView.frame, touchLocation))
            {
                didTapValidVertice = YES;
                [_game tappedVertexID:verticeView.tag];
                break;
            }
        }
        
        if (!didTapValidVertice) {
            [_game tappedOutSide];
        }
    }
}

#pragma mark Demo

- (void)nextDemoTurn;
{
    self.demoTurn++;

    switch (_demoTurn) {
        case 1:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 2:
            [_game tappedVertexID:22];
            break;
            
        case 3:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;

        case 4:
            [_game tappedVertexID:1];
            break;

        case 5:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 6:
            [_game tappedVertexID:23];
            break;
            
        case 7:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 8:
            [_game tappedVertexID:2];
            break;

        case 9:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 10:
            [_game tappedVertexID:3];
            break;
            
        case 11:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 12:
            [_game tappedVertexID:24];
            break;
            
        case 13:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 14:
            [_game tappedVertexID:10];
            break;
            
        case 15:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 16:
            [_game tappedVertexID:11];
            break;

        case 17:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 18:
            [_game tappedVertexID:4];
            break;

        case 19:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 20:
            [_game tappedVertexID:5];
            break;

        case 21:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 22:
            [_game tappedVertexID:8];
            break;
            
        case 23:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 24:
            [_game tappedVertexID:14];
            break;

        case 25:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 26:
            [_game tappedVertexID:13];
            break;
            
        case 27:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 28:
            [_game tappedVertexID:6];
            break;

        case 29:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 30:
            [_game tappedVertexID:21];
            break;

        case 31:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 32:
            [_game tappedVertexID:17];
            break;
            
        case 33:
            [_game tappedCoinStackForPlayerID:C_PLAYERONE_ID];
            break;
            
        case 34:
            [_game tappedVertexID:20];
            break;
            
        case 35:
            [_game tappedCoinStackForPlayerID:C_PLAYERTWO_ID];
            break;
            
        case 36:
            [_game tappedVertexID:19];
            break;
            
            ///// Placement over //////
            
        case 37:
            [_game tappedVertexID:8];
            break;
            
        case 38:
            [_game tappedVertexID:7];
            break;

        case 39:
            [_game tappedVertexID:5];
            break;
            
        case 40:
            [_game tappedVertexID:8];
            break;

        case 41:
            [_game tappedVertexID:7];
            break;

        case 42:
            [_game tappedVertexID:12];
            break;

        case 43:
            [_game tappedVertexID:6];
            break;
            
        default:
            break;
    }
    
    if (_demoTurn < 44)
    {
        [self performSelector:@selector(nextDemoTurn) withObject:nil afterDelay:TURN_INTERVAL];
    }
}

- (void)startDemo;
{
    self.demoTurn = 0;
    [self nextDemoTurn];
    
    [self performSelector:@selector(nextDemoTurn) withObject:nil afterDelay:TURN_INTERVAL];
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
