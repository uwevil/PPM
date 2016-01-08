//
//  ViewController.h
//  Dizainier
//
//  Created by Cao Sang DOAN on 22/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (atomic) int dix;

@property (atomic) int unit;

@property (retain, nonatomic) IBOutlet UIStepper *stepper;

@property (retain, nonatomic) IBOutlet UILabel *geekLabel;

@property (retain, nonatomic) IBOutlet UISwitch *geekSwitcher;

@property (retain, nonatomic) IBOutlet UISegmentedControl *dizaine;

@property (retain, nonatomic) IBOutlet UISegmentedControl *unite;

@property (retain, nonatomic) IBOutlet UILabel *numberLabel;

@property (retain, nonatomic) IBOutlet UISlider *slider;


- (IBAction)stepperAction:(UIStepper *)sender;

- (IBAction)geekAction:(UISwitch *)sender;

- (IBAction)dizainAction:(UISegmentedControl *)sender;

- (IBAction)uniteAction:(UISegmentedControl *)sender;

- (IBAction)sliderAction:(UISlider *)sender;

- (IBAction)resetAction:(UIButton *)sender;


@end

