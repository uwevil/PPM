//
//  ViewController.m
//  MauvaisePluie_OC
//
//  Created by Cao Sang DOAN on 18/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

UIImageView *imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    _isPlaying = false;
    
    _play = [UIButton buttonWithType:UIButtonTypeCustom];
    [_play setTitle:@"PLAY" forState:UIControlStateNormal];
    [_play setTitle:@"" forState:UIControlStateHighlighted];
    _play.titleLabel.font = [UIFont systemFontOfSize:frame.size.width/10];
    [_play sizeToFit];
    [_play setFrame:CGRectMake(frame.size.width/2 - _play.bounds.size.width/2, frame.size.height/2 - _play.bounds.size.height/2, _play.bounds.size.width, _play.bounds.size.height)];
    [_play addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchDown];
    
    _currentScore = 0;
    
    _isReset = false;
    
    imageView = [[UIImageView alloc] init];
    
    UIImage *imageTmp = [UIImage imageNamed:@"background"];
    [imageView setImage:imageTmp];
    [imageView addMotionEffect:[[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis]];
    [imageView addMotionEffect:[[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis]];
    [imageView setFrame:CGRectMake(( - imageTmp.size.width + frame.size.width)/2 , ( - imageTmp.size.height + frame.size.height)/2, imageTmp.size.width, imageTmp.size.height)];

    _prefView = [[PrefView alloc] initWithFrame:frame];
    _prefView.hidden = true;
    
    _gameView = [[GameView alloc] initWithFrame:frame];
    [_gameView disableButton];
    
    _scoreView = [[ScoreView alloc] initWithFrame:frame];
    _scoreView.hidden = true;
    
    [[self view] addSubview:imageView];
    [[self view] addSubview:_gameView];
    [[self view] addSubview:_prefView];
    [[self view] addSubview:_scoreView];
    [[self view] addSubview:_play];
    [_gameView release];
    [_prefView release];
    [_scoreView release];
}

- (void)dealloc{
    [super dealloc];
    
    [_gameView dealloc];
    [_prefView dealloc];
    [_scoreView dealloc];
    [_timerScreen dealloc];
    [imageView dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [_gameView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [imageView setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_prefView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [_scoreView viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)preference:(UIButton *)sender {
    if (_play.hidden == false){
        [_timerScreen invalidate];
        _timerScreen = nil;
        [_gameView disableTimerAsteroide];

        _prefView.hidden = false;
        _gameView.hidden = true;
        _play.hidden = true;
    }
}

- (void) donePrefView:(UIButton *) sender{
    _prefView.hidden = true;
    _gameView.hidden = false;
    [_gameView setLevel:([_prefView getLevel] + 1)];
    if (_isPlaying){
        _timerScreen = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshScreen:) userInfo:nil repeats:true];
        [_gameView activeTimerAsteroide];
    }
    if (!_isPlaying){
        _play.hidden = false;
    }
}

- (void) play:(UIButton *)b{
    [_gameView enableButton];
    _timerScreen = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshScreen:) userInfo:nil repeats:true];
    [_gameView activeTimerAsteroide];
    _play.hidden = true;
    _isPlaying = true;
}

- (void) score:(UIButton *)sender{
    [_timerScreen invalidate];
    _timerScreen = nil;
    [_gameView disableTimerAsteroide];
    _scoreView.hidden = false;
    _gameView.hidden = true;
    [_scoreView.nameField setEnabled:true];
    _scoreView.nameField.hidden = false;
    _play.hidden = true;
}

- (void) reset{
    _currentScore = 0;

    [_gameView reset];
    _play.hidden = false;

}

- (void) doneScoreView:(UIButton *) sender{
    if (_isReset){
        _isReset = false;
        [self reset];
    }else{
        if (!_isPlaying){
            _play.hidden = false;
        }else{
            _play.hidden = true;
            _timerScreen = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshScreen:) userInfo:nil repeats:true];
            [_gameView activeTimerAsteroide];
        }
    }
    
    _gameView.hidden = false;
    _scoreView.hidden = true;
    [_scoreView.nameField resignFirstResponder];
}

- (void) goLeftDown:(UIButton *) sender{
    _gameView.buttonDown = 1;
    [self refreshButton:sender];
    _timerButton = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(refreshButton:) userInfo:nil repeats:true];
}

- (void) goLeftUp:(UIButton *)sender{
    _gameView.buttonDown = 0;
    [_timerButton invalidate];
    _timerButton = nil;
}

- (void) goRightDown:(UIButton *) sender{
    _gameView.buttonDown = 2;
    [self refreshButton:sender];
    _timerButton = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(refreshButton:) userInfo:nil repeats:true];
}

- (void) goRightUp:(UIButton *)sender{
    _gameView.buttonDown = 0;
    [_timerButton invalidate];
    _timerButton = nil;
}

- (void) refreshButton:(UIButton *)sender{    
    if (_gameView.buttonDown == 1){
        CGRect frame = _gameView.frame;
        
        int x = _gameView.player.center.x - frame.size.width/20;
        if (x <= 0){
            x = 0;
        }
        
        [_gameView.player setFrame:CGRectMake(x, frame.size.height - 20 - frame.size.width/15, _gameView.player.bounds.size.width, _gameView.player.bounds.size.height)];
    } else if (_gameView.buttonDown == 2){
        CGRect frame = _gameView.frame;
        
        int x = _gameView.player.center.x - _gameView.player.bounds.size.width + frame.size.width/20;
        if (x >= frame.size.width - _gameView.player.bounds.size.width){
            x = frame.size.width - _gameView.player.bounds.size.width;
        }
        [_gameView.player setFrame:CGRectMake(x, frame.size.height - 20 - frame.size.width/15, _gameView.player.bounds.size.width, _gameView.player.bounds.size.height)];
    }

}

- (void) refreshScreen:(NSTimer *) t{
    CGRect frame = [[UIScreen mainScreen] bounds];

    CGFloat px = _gameView.player.layer.position.x;
    CGFloat py = _gameView.player.layer.position.y;
 //   CGFloat pw = _gameView.player.bounds.size.width;
    CGFloat ph = _gameView.player.bounds.size.height;

    CGFloat ax, ay, ah, aw;

    for (int i = 0; i < _gameView.asteroides.count; ++i){
        NSMutableArray *dict = [_gameView.asteroides objectAtIndex:i];
        UIImageView *currentView = [dict objectAtIndex:1];
        float angle = [[dict objectAtIndex:2] floatValue];
        int random = [[dict objectAtIndex:3] integerValue];
        
        int tmp = [[dict objectAtIndex:0] integerValue];
        CGFloat y = currentView.layer.position.y + tmp*0.5;
        CGFloat x = currentView.layer.position.x;
        if ((y + ph) > frame.size.height){
            [currentView removeFromSuperview];
            [_gameView.asteroides removeObjectAtIndex:i];
            _currentScore += 1;
        }else{
            if (_gameView.level >= 3 && tmp % 3 == 0){
                x = currentView.layer.position.x + tmp*0.5;
            }else if (_gameView.level >= 3 && tmp % 3 == 1){
                x = currentView.layer.position.x - tmp*0.5;
            }
            
            currentView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
                        
            angle += random/1000.;
            
            if (angle > 6.28){
                angle = 0;
            }
            
            [dict removeObjectAtIndex:2];
            [dict insertObject:[NSString stringWithFormat:@"%f", angle] atIndex:2];
            [currentView setTransform:CGAffineTransformMakeRotation(angle)];
            
            currentView.layer.position = CGPointMake(x, y);
            
        //    [currentView setFrame:CGRectMake(x, y, currentView.frame.size.width, currentView.frame.size.width)];
            
            ax = currentView.layer.position.x;
            ay = currentView.layer.position.y;
            ah = currentView.frame.size.height;
            aw = currentView.frame.size.width;
            
            if ((((px < ax + aw) && (px > ax)) || ((px + aw > ax) && ((px + aw) < (ax + aw)))) && (py < (ay + ah)) && (py > ay)) {
                [_gameView disableTimerAsteroide];
                [_gameView disableButton];
                [_timerScreen invalidate];
                _timerScreen = nil;
                _isReset = true;
                
                [_gameView.player setTransform:CGAffineTransformMakeRotation(M_PI)];
        
                NSTimer *timerTmp = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerTmp:) userInfo:nil repeats:false];
                
                _isPlaying = false;
                
                break;
            }
        }
    }
    
    _gameView.currentScore = _currentScore;
    [_gameView refreshScore];
    [_gameView setNeedsDisplay];

    _scoreView.currentScore = _currentScore;
    [_scoreView.currentScoreLabel setText:[NSString stringWithFormat:@"%d", _currentScore]];
    [_scoreView sizeToFit];
    [_scoreView setNeedsDisplay];
}

- (void) timerTmp:(NSTimer *)t{
    [self score:nil];
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeRight;
}



@end










