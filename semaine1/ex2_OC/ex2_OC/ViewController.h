//
//  ViewController.h
//  ex2_OC
//
//  Created by Cao Sang DOAN on 13/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *couleur;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
- (IBAction)changeValue:(UIStepper *)sender;

@end

