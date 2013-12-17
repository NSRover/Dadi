//
//  DDVerticeManager.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDVerticesManager.h"
#import "DDVertex.h"
#import "DDBoard.h"
#import "DDDadi.h"

@interface DDVerticesManager ()

@property (nonatomic, weak) DDBoard* board;

@end

@implementation DDVerticesManager

#pragma mark Public

- (id)initWithBoard:(DDBoard *)board;
{
    self = [super init];
    
    self.board = board;
    
    [self reset];
    
    return self;
}

- (void)reset;
{
    [self createVertices];
    [self connectVertices];
    [self connectViews];
}

- (DDVertex *)vertexForID:(int)index;
{
    for (DDVertex *vertex in _vertices) {
        if (vertex.ID == index) {
            return vertex;
        }
    }
    return nil;
}

#pragma mark Functional

- (BOOL)placeCoinOnVertex:(DDVertex *)vertex;
{
    vertex.coin = _board.coinManager.selectedCoin;

    [_board.coinManager moveCoinToVertex:vertex];
    
    return YES;
}

- (NSArray *)allNeighbourVerticesForVertex:(DDVertex *)vertex inDirection:(NeighbourDirection)direction;
{
    NSMutableArray* allDirectionalNeighbours = [[NSMutableArray alloc] initWithCapacity:3];
    for (DDVertex *candidate in _vertices) {
        if (direction == NeighbourDirectionHorizontal)
        {
            if (candidate.row == vertex.row) {
                [allDirectionalNeighbours addObject:candidate];
            }
        }
        else
        {
            if (candidate.coloumn == vertex.coloumn)
            {
                [allDirectionalNeighbours addObject:candidate];
            }
        }
    }
    
    return allDirectionalNeighbours;
}

- (void)removeCoinFromVertex:(DDVertex *)vertex;
{
    vertex.coin = nil;
}

#pragma mark Private

- (void)connectVertices;
{
    NSArray* neighbourhood = [C_NEIGHBOURHOOD componentsSeparatedByString:@"|"];
    for (NSString* neighbour in neighbourhood) {
        NSArray *components = [neighbour componentsSeparatedByString:@":"];
        
        //Vertex, row and coloumn
        NSString* vertex = [components objectAtIndex:0];
        NSArray* componentsVertex = [vertex componentsSeparatedByString:@"-"];
        int vertexIndex = [[componentsVertex objectAtIndex:0] intValue];
        NSString* rowColString = [componentsVertex objectAtIndex:1];
        int row = [[[rowColString componentsSeparatedByString:@","] objectAtIndex:0] intValue];
        int coloumn = [[[rowColString componentsSeparatedByString:@","] objectAtIndex:1] intValue];
        
        //Neighbours
        NSArray* neighbours = [((NSString *)[components objectAtIndex:1]) componentsSeparatedByString:@","];
        NSMutableArray* neighboursArray = [[NSMutableArray alloc] initWithCapacity:neighbours.count];
        for (NSString* nextNeighbour in neighbours) {
            int neighbourID = [nextNeighbour intValue];
            [neighboursArray addObject:[_vertices objectAtIndex:neighbourID]];
        }
        
        //vertex
        DDVertex* actualVertex = [_vertices objectAtIndex:vertexIndex];
        actualVertex.row = row;
        actualVertex.coloumn = coloumn;
        actualVertex.neighbours = neighboursArray;
    }
}

- (void)createVertices;
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:C_TOTAL_VERTICES];

    //create 24 vertices object
    for (int ii = 0; ii < C_TOTAL_VERTICES; ii++) {
        DDVertex *vertex = [[DDVertex alloc] init];
        vertex.ID = (ii + 1);
        
        [array addObject:vertex];
    }
    
    self.vertices = array;
}

- (void)connectViews;
{
    if ([_board.game.delegate respondsToSelector:@selector(viewForVerticeIndex:)]) {
        for (int ii = 0; ii < _vertices.count; ii++) {
            DDVertex *vertex = [_vertices objectAtIndex:ii];
            vertex.view = [_board.game.delegate viewForVerticeIndex:vertex.ID];
        }
    }
}

- (NSString *)description
{
    NSMutableString* description = [[NSMutableString alloc] initWithFormat:@"Description of all Vertices\n"];
    for (DDVertex *vertex in _vertices) {
        NSString* string = [NSString stringWithFormat:@"    Vertex: %d, neighbours: %@\n", vertex.ID, vertex.neighbours];
        [description appendString:string];
    }
    return description;
}

@end
