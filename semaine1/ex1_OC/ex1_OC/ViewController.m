//
//  ViewController.m
//  ex1_OC
//
//  Created by Cao Sang DOAN on 12/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAction:(id)sender {
    NSLog(@"button pressed!!!");
    
    if ([[_buttonTitle currentTitle] isEqualToString:@"Dis bonjour!"])
    {
        [_label setText:@"Bonjour!"];
        [_buttonTitle setTitle:@"Dis au revoir!" forState:UIControlStateNormal];
    }
    else
    {
        [_label setText:@"Au revoir!"];
        [_buttonTitle setTitle:@"Dis bonjour!" forState:UIControlStateNormal];
    }
}
@end
