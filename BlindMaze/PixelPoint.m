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
    NSLog(@"Other point's crap: ");
    [otherPoint logPixelCords];
    NSLog(@"your crap: ");
    [self logPixelCords];
    
    NSLog(@"X abs: %d Y abs: %d", (abs(otherPoint.xCord-self.xCord)), abs(otherPoint.yCord-self.yCord));
    
    return(abs(otherPoint.xCord-self.xCord)<=radius && abs(otherPoint.yCord-self.yCord) <=radius);
}

-(id)initWithX:(int)x withY:(int)y{
    if (self = [super init]){
        self.xCord = x;
        self.yCord = y;
    }
    return self;
};

-(void) logPixelCords{
    NSLog(@"Pixel cords: (%d, %d)",self.xCord, self.yCord);
}



@end
