//
//  PixelPoint.m
//  BlindMaze
//
//  Created by Faraz Abidi on 1/24/15.
//  Copyright (c) 2015 Shane Rosse. All rights reserved.
//

#import "PixelPoint.h"

@implementation PixelPoint

/*
 Constructor should require xCord and yCord
 */

-(bool) isNearOtherPoint:(PixelPoint *)otherPoint inRadius:(int)radius{
    return(abs(otherPoint.xCord-self.xCord)<=radius && abs(otherPoint.yCord-self.yCord) <=radius);
}

-(id)initWithX:(int)x withY:(int)y{
    if (self = [super init]){
        self.xCord = x;
        self.yCord = y;
    }
    return self;
};



@end
