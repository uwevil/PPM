//
//  ViewController.m
//  MiniNav_OC
//
//  Created by Cao Sang DOAN on 11/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

MyView *myView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScreen *screen = [UIScreen mainScreen];
    myView = [[MyView alloc] initWithFrame:screen.bounds];
    [self setView:myView];
    [myView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillTransitionToSize:(CGSize) size{
    [myView viewWillTransitionToSize:size];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [myView viewWillTransitionToSize:size];
}


@end
