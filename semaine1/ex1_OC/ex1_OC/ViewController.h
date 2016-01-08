//
//  ViewController.h
//  ex1_OC
//
//  Created by Cao Sang DOAN on 12/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitle;

- (IBAction)buttonAction:(id)sender;

@end

