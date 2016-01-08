//
//  ViewController.m
//  NuancierRVB
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
    
    _rLabel.text = @"R: 50%";
    _vLabel.text = @"V: 50%";
    _bLabel.text = @"B: 50%";
    
    [_switchButton setOn:NO];
    
    _rSlider.minimumValue = 0;
    _rSlider.maximumValue = 1;
    _rSlider.value = 0.5;
    
    _vSlider.minimumValue = 0;
    _vSlider.maximumValue = 1;
    _vSlider.value = 0.5;

    _bSlider.minimumValue = 0;
    _bSlider.maximumValue = 1;
    _bSlider.value = 0.5;

    [_actuelView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    [_precendentButton setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    [_penultiemeButton setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    
    _tab = [[NSMutableArray alloc] initWithObjects: 
                [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1],
                [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1], nil ];
    
    _inOut = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_precendentButton release];
    [_penultiemeButton release];
    [_actuelView release];
    [_rLabel release];
    [_rSlider release];
    [_vLabel release];
    [_vSlider release];
    [_bLabel release];
    [_bSlider release];
    [_switchButton release];
    [_enregistrerButton release];
    [_precendentButton release];
    [_resetButton release];
    [_tab release];
    
    [super dealloc];
}

- (IBAction)precedentAction:(UIButton *)sender
{
    UIColor *save;
    if (_inOut)
    {
        save = _tab[1];
    }
    else
    {
        save = _tab[0];
    }
    
    [_actuelView setBackgroundColor:save];
    
    CGFloat red, green, blue;
    int tmp;
    
    [save getRed:&red green:&green blue:&blue alpha:nil];
    
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(red * 10)* 10);
        _rSlider.value = tmp / 100.;
        _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];
        
        tmp = (int) ((int)(green * 10)* 10);
        _vSlider.value = tmp / 100.;
        _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];
        
        tmp = (int) ((int)(blue * 10)* 10);
        _bSlider.value = tmp / 100.;
        _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
    }
    else
    {
        tmp = red * 100;
        _rSlider.value = tmp / 100.;
        _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];
        
        tmp = green * 100;
        _vSlider.value = tmp / 100.;
        _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];
        
        tmp = blue * 100;
        _bSlider.value = tmp / 100.;
        _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
    }

}

- (IBAction)penultiemeAction:(UIButton *)sender
{
    UIColor *save;
    if (_inOut)
    {
        save = _tab[0];
    }
    else
    {
        save = _tab[1];
    }
    
    [_actuelView setBackgroundColor:save];
    
    CGFloat red, green, blue;
    int tmp;
    
    [save getRed:&red green:&green blue:&blue alpha:nil];
    
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(red * 10)* 10);
        _rSlider.value = tmp / 100.;
        _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];
        
        tmp = (int) ((int)(green * 10)* 10);
        _vSlider.value = tmp / 100.;
        _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];
        
        tmp = (int) ((int)(blue * 10)* 10);
        _bSlider.value = tmp / 100.;
        _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
    }
    else
    {
        tmp = red * 100;
        _rSlider.value = tmp / 100.;
        _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];
        
        tmp = green * 100;
        _vSlider.value = tmp / 100.;
        _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];
        
        tmp = blue * 100;
        _bSlider.value = tmp / 100.;
        _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
    }
}

- (IBAction)rSliderAction:(UISlider *)sender
{
    int tmp;
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(_rSlider.value * 10)* 10);
        _rSlider.value = (float)tmp / 100.;
    }
    else
    {
        tmp = _rSlider.value * 100;
    }
        
    _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];
    [_actuelView setBackgroundColor:[UIColor colorWithRed:_rSlider.value green:_vSlider.value blue:_bSlider.value alpha:1]];  
    
}

- (IBAction)vSliderAction:(UISlider *)sender{
    int tmp;
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(_vSlider.value * 10)* 10);
        _vSlider.value = (float)tmp / 100.;
    }
    else
    {
        tmp = _vSlider.value * 100;
    }
    
    _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];
    [_actuelView setBackgroundColor:[UIColor colorWithRed:_rSlider.value green:_vSlider.value blue:_bSlider.value alpha:1]];  
    
}

- (IBAction)bSliderAction:(UISlider *)sender
{
    int tmp;
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(_bSlider.value * 10)* 10);
        _bSlider.value = (float)tmp / 100.;
    }
    else
    {
        tmp = _bSlider.value * 100;
    }
    
    _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
    [_actuelView setBackgroundColor:[UIColor colorWithRed:_rSlider.value green:_vSlider.value blue:_bSlider.value alpha:1]];  
    
}

- (IBAction)enregistrerAction:(UIButton *)sender
{
    UIColor *save = [[UIColor colorWithRed:_rSlider.value green:_vSlider.value blue:_bSlider.value alpha:1] copy];
    
    if (_inOut)
    {
        [_tab removeObjectAtIndex:0];
        [_tab insertObject:save atIndex:0];
        [_precendentButton setBackgroundColor:save];
        [_penultiemeButton setBackgroundColor:_tab[1]];
        _inOut = NO;
    }
    else
    {
        [_tab removeObjectAtIndex:1];
        [_tab insertObject:save atIndex:1];
        [_precendentButton setBackgroundColor:save];
        [_penultiemeButton setBackgroundColor:_tab[0]];
        _inOut = YES;
    }
    
}

- (IBAction)resetAction:(UIButton *)sender {
    _rSlider.value = 0.5;
    _vSlider.value = 0.5;
    _bSlider.value = 0.5;
    
    _rLabel.text = @"R: 50%";
    _vLabel.text = @"V: 50%";
    _bLabel.text = @"B: 50%";
}

- (IBAction)switchAction:(UISwitch *)sender
{
    int tmp;
    if ([_switchButton isOn])
    {
        tmp = (int) ((int)(_rSlider.value * 10)* 10);
        _rSlider.value = (float)tmp / 100.;
        _rLabel.text = [NSString stringWithFormat:@"R: %d%%", tmp];

        tmp = (int) ((int)(_vSlider.value * 10)* 10);
        _vSlider.value = (float)tmp / 100.;
        _vLabel.text = [NSString stringWithFormat:@"V: %d%%", tmp];

        tmp = (int) ((int)(_bSlider.value * 10)* 10);
        _bSlider.value = (float)tmp / 100.;
        _bLabel.text = [NSString stringWithFormat:@"B: %d%%", tmp];
        
        [_actuelView setBackgroundColor:[UIColor colorWithRed:_rSlider.value green:_vSlider.value blue:_bSlider.value alpha:1]];  
    }
}
@end
