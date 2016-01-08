//
//  ViewController.m
//  NuancierRVBGeek_OC
//
//  Created by Cao Sang DOAN on 03/10/15.
//  Copyright © 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@interface ViewController ()

@end

@implementation ViewController

MyView *myView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect frame = [screen bounds];
    myView = [[MyView alloc] initWithFrame:frame];
    [myView setBackgroundColor:UIColor.whiteColor];
    [self setView:myView];
    [myView release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
