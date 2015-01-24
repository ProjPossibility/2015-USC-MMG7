//
//  MazeViewController.m
//  BlindMaze
//
//  Created by Shane Rosse on 1/23/15.
//  Copyright (c) 2015 Shane Rosse. All rights reserved.
//

#import "MazeViewController.h"
#import "MazeView.h"

@interface MazeViewController ()

@end

@implementation MazeViewController

- (void)loadView
{
    self.view = [[MazeView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
