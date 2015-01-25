//
//  MazeView.m
//  BlindMaze
//
//  Created by Shane Rosse on 1/23/15.
//  Copyright (c) 2015 Shane Rosse. All rights reserved.
//

#import "MazeView.h"
#import "Player1.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MazeView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;

@property (nonatomic, weak) Player1 *player1;

@end

@implementation MazeView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        
        [self addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        NSMutableArray * ppArray = [[NSMutableArray alloc] init];
        
        //let's say x distance can vary by 20 if safetyRad is 30
        int curX = arc4random_uniform(350);
        for (int i = 20; i < 600; i = i + 20) {
            int randomChange = (int)arc4random_uniform(31) - 10;
            int nextX = curX+randomChange;
            if(nextX>0 && nextX < 350)
                curX = nextX;
            PixelPoint * point = [[PixelPoint alloc] initWithX:curX withY:i];
            [ppArray addObject:point];
        }
        self.leftGrid = [[Grid alloc] initWithIsLeft:true withPPArray:ppArray];
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        Player1 *player1 = [[Player1 alloc] init];
        player1.location = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = player1;
    }
    
    [self setNeedsDisplay];
}



/*To avoid excessive array checking
 1)store previous touch's point
 2)if current touch's point is more than 5 away from prev touch's point,
 call playMove function
 */
- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{

    int result = 7;
    // Let's put in a log statement to see the order of events
    //NSLog(@"%@", NSStringFromSelector(_cmd));
    //NSLog(@"NEW TOUCHES MOVED");
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Player1 *player1 = self.linesInProgress[key];
        
        player1.location = [t locationInView:self];
        
        CGPoint point = [t locationInView:t.view];
        CGPoint pointOnScreen = [t.view convertPoint:point fromView:nil];
        
        PixelPoint *playerTouch = [[PixelPoint alloc] initWithX:(int)pointOnScreen.x withY:(int)pointOnScreen.y];
        
        //NSLog(@"Point - %d, %d", (int)pointOnScreen.x, (int)pointOnScreen.y);
        [playerTouch logPixelCords];
        result = [self.leftGrid playersMoveWithPoint:playerTouch wasATap:false];
        
        
        
        //NSLog(@"Point - %f, %f", pointOnScreen.x, pointOnScreen.y);
        self.backgroundColor = [self yBasedColor:(double)pointOnScreen.y xBasedColor:(double)pointOnScreen.x];
    }
    
    
    
    if (result == 1) {
        if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
        {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
        }
        else
        {
            // Not an iPhone: so doesn't have vibrate
        }
        
        //NSLog(@"BAD AREA");
    } else if (result == 2)
        
    {
        NSLog(@"You've won!");
    }
    
    
    
    [self setNeedsDisplay];
}


- (UIColor *) yBasedColor:(double)yPosition xBasedColor:(double)xPosition
{
    //colors based on y-values
    double red = yPosition / 700.0;//pointOnScreen.y / 200;
    double green = yPosition / 700.0; //arc4random() % 255 / 255.0;
    double blue =  yPosition / 700.0; //arc4random() % 255 / 255.0;
    
    red = red - (350 - xPosition)/1600;
    blue = blue - xPosition/1200;
    green = green - xPosition/1200;
    
    UIColor *posColor = [UIColor colorWithRed:red green:green blue:blue alpha: 1.0];
    
    return posColor;
}

/*Implement a better color selection method, taking y position as a parameter
 */
-(UIColor *)randomColor
{
    double red = arc4random() % 255 / 255.0;
    double green = arc4random() % 255 / 255.0;
    double blue = arc4random() % 255 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //NSLog(@"%@", color);
    return color;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)other
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    
    return NO;
}


- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    
    //CGPoint point = [gr locationInView:self]; //This point is the location of our single tap
    
    [self setNeedsDisplay];
}


@end
