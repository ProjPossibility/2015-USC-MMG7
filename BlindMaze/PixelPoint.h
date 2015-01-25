//
//  PixelPoint.h
//  BlindMaze
//
//  Created by Faraz Abidi on 1/24/15.
//  Copyright (c) 2015 Shane Rosse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PixelPoint : NSObject
@property int xCord, yCord;
-(bool)isNearOtherPoint:(PixelPoint *) otherPoint inRadius:(int)radius;
-(id)initWithX:(int)x withY:(int)y;
-(void)logPixelCords;
@end
