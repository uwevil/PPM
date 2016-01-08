//
//  ViewController.h
//  MauvaisePluie_OC
//
//  Created by Cao Sang DOAN on 18/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefView.h"
#import "GameView.h"
#import "ScoreView.h"

@interface ViewController : UIViewController 

@property(nonatomic, strong) GameView *gameView;
@property(nonatomic, strong) PrefView *prefView;
@property(nonatomic, strong) ScoreView *scoreView;
@property(nonatomic, strong) UIButton *play;

@property(nonatomic) int currentScore;

@property(nonatomic) bool isReset;

@property(nonatomic, retain) NSTimer *timerScreen;
@property(nonatomic, retain) NSTimer *timerButton;

@property(nonatomic) bool isPlaying;

- (void) preference:(UIButton *)sender ;

- (void) score:(UIButton *)sender;

- (void) donePrefView:(UIButton *) sender;

- (void) doneScoreView:(UIButton *) sender;

- (void) goRightUp:(UIButton *) sender;

- (void) goRightDown:(UIButton *) sender;

- (void) goLeftUp:(UIButton *) sender;

- (void) goLeftDown:(UIButton *) sender;

- (void) reset;

@end

