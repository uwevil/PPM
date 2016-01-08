//
//  GameView.h
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import <UIKit/UIKit.h>
#import "PrefView.h"

@interface GameView : UIView
@property(nonatomic, strong) UIButton *prefButton;
@property(nonatomic, strong) UIButton *scoreButton;
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UIButton *leftButton;
@property(nonatomic, strong) UIButton *rightButton;
@property(nonatomic, retain) UIImageView *player;

@property(nonatomic, retain) NSMutableArray *images;
@property(atomic, retain) NSMutableArray *asteroides;
@property(nonatomic, retain) NSTimer *timerAsteroide;

@property(nonatomic) int currentScore;
@property(nonatomic, retain) UILabel *currentScoreLabel;

@property(atomic) int buttonDown;

@property(nonatomic) NSInteger level;

- (void) refreshScore;

- (void) setLevel:(NSInteger ) l;

- (void) activeTimerAsteroide;

- (void) disableTimerAsteroide;

- (void) enableButton;

- (void) disableButton;

- (void) reset;

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator;

@end
