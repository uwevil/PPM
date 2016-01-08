//
//  ViewController.m
//  Dizainier
//
//  Created by Cao Sang DOAN on 22/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _stepper.minimumValue = 0;
    _stepper.maximumValue = 99;
    _stepper.stepValue = 1;
    
    _slider.minimumValue = 0;
    _slider.maximumValue = 99;
    [_slider setValue:0];
    
    [_geekSwitcher setOn:NO];
    
    [_numberLabel setTextColor:UIColor.blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_stepper release];
    [_geekLabel release];
    [_geekSwitcher release];
    [_dizaine release];
    [_unite release];
    [_numberLabel release];
    [_slider release];

    [super dealloc];
}

- (IBAction)stepperAction:(UIStepper *)sender {
   
    int value = [_stepper value];
    _dix = value / 10;
    _unit = value % 10;
    
    [_slider setValue:value];
    _dizaine.selectedSegmentIndex = _dix;
    _unite.selectedSegmentIndex = _unit; 
    
    if ([_geekSwitcher isOn])
    {
        
        _numberLabel.text = [NSString stringWithFormat:@"%02x", value];
    }
    else
    {
        _numberLabel.text = [NSString stringWithFormat:@"%d", value];
    }
    
    int tmp = value % 10;
    
    switch (tmp) {
        case 0:
            [_numberLabel setTextColor:UIColor.blueColor];
            break;
        case 1:
            [_numberLabel setTextColor:UIColor.redColor];
            break;
        case 2:
            [_numberLabel setTextColor:UIColor.greenColor];
            break;
        case 3:
            [_numberLabel setTextColor:UIColor.grayColor];
            break;
        case 4:
            [_numberLabel setTextColor:UIColor.yellowColor];
            break;
        case 5:
            [_numberLabel setTextColor:UIColor.cyanColor];
            break;
        case 6:
            [_numberLabel setTextColor:UIColor.blackColor];
            break;
        case 7:
            [_numberLabel setTextColor:UIColor.purpleColor];
            break;
        case 8:
            [_numberLabel setTextColor:UIColor.magentaColor];
            break;
        case 9:
            [_numberLabel setTextColor:UIColor.orangeColor];
            break;
    }
}

- (IBAction)geekAction:(UISwitch *)sender {
    if ([_geekSwitcher isOn])
    {
        _geekLabel.text = @"Geek";
        _numberLabel.text = [NSString stringWithFormat:@"%02x", _dix*10+_unit];
    }
    else
    {
        _geekLabel.text = @"Normal";
        _numberLabel.text = [NSString stringWithFormat:@"%d", _dix*10+_unit];
    }
}

- (IBAction)dizainAction:(UISegmentedControl *)sender {
    _dix = (int)_dizaine.selectedSegmentIndex;
    
    int value = _dix * 10 + _unit;
    
    [_slider setValue:value];
    [_stepper setValue:value];
    
    if ([_geekSwitcher isOn])
    {
        _numberLabel.text = [NSString stringWithFormat:@"%02x", value];
    }
    else
    {
        _numberLabel.text = [NSString stringWithFormat:@"%d", value];
    }
    
    int tmp = value % 10;
    
    switch (tmp) {
        case 0:
            [_numberLabel setTextColor:UIColor.blueColor];
            break;
        case 1:
            [_numberLabel setTextColor:UIColor.redColor];
            break;
        case 2:
            [_numberLabel setTextColor:UIColor.greenColor];
            break;
        case 3:
            [_numberLabel setTextColor:UIColor.grayColor];
            break;
        case 4:
            [_numberLabel setTextColor:UIColor.yellowColor];
            break;
        case 5:
            [_numberLabel setTextColor:UIColor.cyanColor];
            break;
        case 6:
            [_numberLabel setTextColor:UIColor.blackColor];
            break;
        case 7:
            [_numberLabel setTextColor:UIColor.purpleColor];
            break;
        case 8:
            [_numberLabel setTextColor:UIColor.magentaColor];
            break;
        case 9:
            [_numberLabel setTextColor:UIColor.orangeColor];
            break;
    }

}

- (IBAction)uniteAction:(UISegmentedControl *)sender {
    _unit = (int)_unite.selectedSegmentIndex;
    
    int value = _dix * 10 + _unit;
    
    [_slider setValue:value];
    [_stepper setValue:value];
    
    if ([_geekSwitcher isOn])
    {
        _numberLabel.text = [NSString stringWithFormat:@"%02x", value];
    }
    else
    {
        _numberLabel.text = [NSString stringWithFormat:@"%d", value];
    }
    
    int tmp = value % 10;
    
    switch (tmp) {
        case 0:
            [_numberLabel setTextColor:UIColor.blueColor];
            break;
        case 1:
            [_numberLabel setTextColor:UIColor.redColor];
            break;
        case 2:
            [_numberLabel setTextColor:UIColor.greenColor];
            break;
        case 3:
            [_numberLabel setTextColor:UIColor.grayColor];
            break;
        case 4:
            [_numberLabel setTextColor:UIColor.yellowColor];
            break;
        case 5:
            [_numberLabel setTextColor:UIColor.cyanColor];
            break;
        case 6:
            [_numberLabel setTextColor:UIColor.blackColor];
            break;
        case 7:
            [_numberLabel setTextColor:UIColor.purpleColor];
            break;
        case 8:
            [_numberLabel setTextColor:UIColor.magentaColor];
            break;
        case 9:
            [_numberLabel setTextColor:UIColor.orangeColor];
            break;
    }

}

- (IBAction)sliderAction:(UISlider *)sender {
    int value = [_slider value];
    _dix = value / 10;
    _unit = value % 10;
    
    [_stepper setValue:value];
    _dizaine.selectedSegmentIndex = _dix;
    _unite.selectedSegmentIndex = _unit; 
    
    if ([_geekSwitcher isOn])
    {
        _numberLabel.text = [NSString stringWithFormat:@"%02x", value];
    }
    else
    {
        _numberLabel.text = [NSString stringWithFormat:@"%d", value];
    }
    
    int tmp = value % 10;
    
    switch (tmp) {
        case 0:
            [_numberLabel setTextColor:UIColor.blueColor];
            break;
        case 1:
            [_numberLabel setTextColor:UIColor.redColor];
            break;
        case 2:
            [_numberLabel setTextColor:UIColor.greenColor];
            break;
        case 3:
            [_numberLabel setTextColor:UIColor.grayColor];
            break;
        case 4:
            [_numberLabel setTextColor:UIColor.yellowColor];
            break;
        case 5:
            [_numberLabel setTextColor:UIColor.cyanColor];
            break;
        case 6:
            [_numberLabel setTextColor:UIColor.blackColor];
            break;
        case 7:
            [_numberLabel setTextColor:UIColor.purpleColor];
            break;
        case 8:
            [_numberLabel setTextColor:UIColor.magentaColor];
            break;
        case 9:
            [_numberLabel setTextColor:UIColor.orangeColor];
            break;
    }

}

- (IBAction)resetAction:(UIButton *)sender {
    
    _dix = 0;
    _unit = 0;
    _stepper.value = 0;
    
    [_slider setValue:0];
    
    [_geekSwitcher setOn:NO];
    
    [_numberLabel setTextColor:UIColor.blueColor];
    
    _dizaine.selectedSegmentIndex = _dix;
    _unite.selectedSegmentIndex = _unit;
    
    _numberLabel.text = @"0";
    _geekLabel.text = @"Normal";
}
@end














