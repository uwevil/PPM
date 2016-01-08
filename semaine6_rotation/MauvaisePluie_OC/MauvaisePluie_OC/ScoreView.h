//
//  ScoreView.h
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import <UIKit/UIKit.h>

@interface ScoreView : UIView <UITextFieldDelegate>
@property(nonatomic, retain) UILabel *labelName1;
@property(nonatomic, retain) UILabel *labelName2;
@property(nonatomic, strong) NSMutableArray *score;
@property(nonatomic, retain) UILabel *labelScore;
@property(nonatomic, retain) UILabel *currentScoreLabel;
@property(nonatomic, retain) UIButton *button;
@property(nonatomic, retain) UITextField *nameField;

@property(nonatomic) NSInteger currentScore;

- (void) reset;

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;

@end
