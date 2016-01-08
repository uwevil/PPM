//
//  PrefView.h
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import <UIKit/UIKit.h>
#import "GameView.h"

@interface PrefView : UIView <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIPickerView *picker;

- (NSArray *) getLevelLabel;
- (NSInteger) getLevel;

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;

@end
