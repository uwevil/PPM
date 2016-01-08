//
//  ViewController.m
//  ex2_OC
//
//  Created by Cao Sang DOAN on 13/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _stepper.maximumValue = 5;
    _stepper.minimumValue = 0;
    _stepper.stepValue = 1;
}

- (IBAction)changeValue:(UIStepper *)sender {
    
    switch ((int)sender.value) {
        case 1:
            [_couleur setBackgroundColor:UIColor.yellowColor];
            break;
        case 2:
            [_couleur setBackgroundColor:UIColor.grayColor];
            break;
        case 3:
            [_couleur setBackgroundColor:UIColor.blackColor];
            break;
        case 4:
            [_couleur setBackgroundColor:UIColor.cyanColor];
            break;
        case 5:
            [_couleur setBackgroundColor:UIColor.redColor];
            break;
        case 0:
            [_couleur setBackgroundColor:UIColor.blueColor];
            break;
    }
}
@end
