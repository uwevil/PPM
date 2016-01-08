//
//  ViewController.h
//  NuancierRVB
//
//  Created by Cao Sang DOAN on 22/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIButton *precendentButton;

@property (retain, nonatomic) IBOutlet UIButton *penultiemeButton;

@property (retain, nonatomic) IBOutlet UIView *actuelView;

@property (retain, nonatomic) IBOutlet UILabel *rLabel;

@property (retain, nonatomic) IBOutlet UISlider *rSlider;

@property (retain, nonatomic) IBOutlet UILabel *vLabel;

@property (retain, nonatomic) IBOutlet UISlider *vSlider;

@property (retain, nonatomic) IBOutlet UILabel *bLabel;

@property (retain, nonatomic) IBOutlet UISlider *bSlider;

@property (retain, nonatomic) IBOutlet UISwitch *switchButton;

@property (retain, nonatomic) IBOutlet UIButton *enregistrerButton;

@property (retain, nonatomic) IBOutlet UIButton *resetButton;

@property (retain, atomic) NSMutableArray* tab;

@property (atomic) BOOL inOut;


- (IBAction)precedentAction:(UIButton *)sender;

- (IBAction)penultiemeAction:(UIButton *)sender;

- (IBAction)rSliderAction:(UISlider *)sender;

- (IBAction)vSliderAction:(UISlider *)sender;

- (IBAction)bSliderAction:(UISlider *)sender;

- (IBAction)enregistrerAction:(UIButton *)sender;

- (IBAction)resetAction:(UIButton *)sender;

- (IBAction)switchAction:(UISwitch *)sender;


@end

