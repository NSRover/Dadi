//
//  DDVerticeManager.m
//  Dadi
//
//  Created by Nirbhay Agarwal on 27/11/13.
//  Copyright (c) 2013 Personal. All rights reserved.
//

#import "DDVerticesManager.h"
#import "DDVertex.h"
#import "DDConstants.h"

@implementation DDVerticesManager

- (void)reset;
{
    [self createVertices];
    [self connectVertices];
}

- (void)connectVertices;
{
    NSArray* neighbourhood = [C_NEIGHBOURHOOD componentsSeparatedByString:@"|"];
    for (NSString* neighbour in neighbourhood) {
        NSArray *components = [neighbour componentsSeparatedByString:@":"];
        int vertex = [[components objectAtIndex:0] intValue];
        NSArray* neighbours = [((NSString *)[components objectAtIndex:1]) componentsSeparatedByString:@","];
        NSMutableArray* neighboursArray = [[NSMutableArray alloc] initWithCapacity:neighbours.count];
        for (NSString* nextNeighbour in neighbours) {
            int neighbourID = [nextNeighbour intValue];
            [neighboursArray addObject:[_vertices objectAtIndex:neighbourID]];
        }
        DDVertex* actualVertex = [_vertices objectAtIndex:vertex];
        actualVertex.neighbours = neighboursArray;
    }
}

- (void)createVertices;
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:C_TOTAL_VERTICES];

    //create 24 vertices object
    for (int ii = 0; ii < C_TOTAL_VERTICES; ii++) {
        DDVertex *vertex = [[DDVertex alloc] init];
        vertex.ID = ii;
        
        [array addObject:vertex];
    }
    
    self.vertices = array;
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
