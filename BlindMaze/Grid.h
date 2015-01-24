//
//  Grid.h
//  BlindMaze
//
//  Created by Faraz Abidi on 1/24/15.
//  Copyright (c) 2015 Shane Rosse. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PixelPoint.h"
@interface Grid : NSObject

@property (nonatomic)bool isLeft; //should be set when initialized. Tells which player's Grid this is
@property (nonatomic)bool hasCollided;
@property (nonatomic)int safetyRad, ppDistance;
@property(strong, nonatomic) NSMutableArray* pixelPointsArray;


-(int)playersMoveWithPoint:(PixelPoint *)playerPoint wasATap:(bool)tap;
-(int)checkCollision:(PixelPoint *)playerPoint;
-(id)initWithIsLeft: (bool)left;
-(id)initWithIsLeft:(bool)left withPPArray: (NSMutableArray *)ppArray;

/*
 Adds a new point to our array of points, but only if the point does not already exist (or is in the radius of existing points)
 Returns false if point already exists
 
 This radius should be significantly smaller than collision radius!
 */
-(bool) addPixelPoint: (PixelPoint *) newPoint;


/* checks if point is in radius of any other point in our points array
 This might more our program really slow if we do this for every touch
 */
-(bool) pixelCollides: (PixelPoint *) yourPoint givenRadius: (int)safetyRad;


@end
