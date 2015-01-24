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

/*

// This is Shane's Branch? '
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
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        
        Player1 *player1 = [[Player1 alloc] init];
        player1.location = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = player1;
    }
    
    [self setNeedsDisplay];
}


//START OF PETER'S COLOR STUFF

- (UIColor *) yBasedColor:(double)yPosition xBasedColor:(double)xPosition
{
    //colors based on y-values
    double red = yPosition / 700.0;//pointOnScreen.y / 200;
    double green = yPosition / 700.0; //arc4random() % 255 / 255.0;
    double blue =  yPosition / 700.0; //arc4random() % 255 / 255.0;
    
    UIColor *posColor = [UIColor colorWithRed:(1-red) green:green blue:blue alpha: 1.0];
    
    return posColor;
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event 
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        Player1 *player1 = self.linesInProgress[key];
        
        player1.location = [t locationInView:self];
        
        CGPoint point = [t locationInView:t.view];
        CGPoint pointOnScreen = [t.view convertPoint:point fromView:nil];
        NSLog(@"Point - %f, %f", pointOnScreen.x, pointOnScreen.y);
        NSLog(@"Touch");
        
        
        //***** changed line below
        self.backgroundColor = [self yBasedColor:(double)pointOnScreen.y xBasedColor:(double)pointOnScreen.x];
        if ((pointOnScreen.x < 100 || pointOnScreen.x > 300)) {
            self.backgroundColor = [UIColor blackColor];
        }
    }
    
    
    // Set and if statement related to the range of our path
    if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
       
    }
    else
    {
        // Not an iPhone: so doesn't have vibrate
    }
    

    
    [self setNeedsDisplay];
}

//END OF PETER'S COLOR STUFF


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
    
    CGPoint point = [gr locationInView:self]; //This point is the location of our single tap
        
    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    
    [self.linesInProgress removeAllObjects];
    [self setNeedsDisplay];
}


@end
