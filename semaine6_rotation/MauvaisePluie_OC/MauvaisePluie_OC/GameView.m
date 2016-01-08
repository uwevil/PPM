//
//  GameView.m
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import "GameView.h"
#import "tgmath.h"

@implementation GameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    [super initWithFrame:frame];
    
    _level = 1;
    _currentScore = 0;
    _buttonDown = 0;
    
    _prefButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_prefButton setTitle:@"Préférence" forState:UIControlStateNormal];
    [_prefButton setTitle:@"" forState:UIControlStateHighlighted];

    _prefButton.titleLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_prefButton sizeToFit];
    [_prefButton setFrame:CGRectMake(frame.size.width - _prefButton.bounds.size.width - 20, 20, _prefButton.bounds.size.width, _prefButton.bounds.size.height)];
    [_prefButton addTarget:self.superview action:@selector(preference:) forControlEvents:UIControlEventTouchDown];
    
    _scoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scoreButton setTitle:@"Score" forState:UIControlStateNormal];
    [_scoreButton setTitle:@"" forState:UIControlStateHighlighted];

    _scoreButton.titleLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_scoreButton sizeToFit];
    [_scoreButton setFrame:CGRectMake(frame.size.width/2 - _scoreButton.bounds.size.width/2, 20, _scoreButton.bounds.size.width, _prefButton.bounds.size.height)];
    [_scoreButton addTarget:self.superview action:@selector(score:) forControlEvents:UIControlEventTouchDown];

    _currentScoreLabel = [[UILabel alloc] init];
    [_currentScoreLabel setText:@"0"];
    [_currentScoreLabel setFont:[UIFont systemFontOfSize:frame.size.width/30]];
    [_currentScoreLabel setTextColor:[UIColor whiteColor]];
    [_currentScoreLabel sizeToFit];
    [_currentScoreLabel setFrame:CGRectMake(frame.size.width/2 - _currentScoreLabel.bounds.size.width/2, 20 + _scoreButton.bounds.size.height+5, _currentScoreLabel.bounds.size.width, _currentScoreLabel.bounds.size.height)];
    
    _levelLabel = [[UILabel alloc] init];
    [_levelLabel setText:@"Level 1"];
    _levelLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_levelLabel setTextColor:[UIColor whiteColor]];
    [_levelLabel setTextAlignment:NSTextAlignmentCenter];
    [_levelLabel sizeToFit];
    [_levelLabel setFrame:CGRectMake(20, 20, _levelLabel.bounds.size.width, _prefButton.bounds.size.height)];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setTitle:@"<<<" forState:UIControlStateNormal];
    [_leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _leftButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [_leftButton sizeToFit];
    [_leftButton setFrame:CGRectMake(20, frame.size.height - 10 - _leftButton.bounds.size.height, _leftButton.bounds.size.width, _leftButton.bounds.size.height)];
    [_leftButton addTarget:self.superview action:@selector(goLeftDown:) forControlEvents:UIControlEventTouchDown];
    [_leftButton addTarget:self.superview action:@selector(goLeftUp:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setTitle:@">>>" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _rightButton.titleLabel.font = [UIFont systemFontOfSize:30];
    [_rightButton sizeToFit];
    [_rightButton setFrame:CGRectMake(frame.size.width - 20 - _rightButton.bounds.size.width, frame.size.height - 10 - _rightButton.bounds.size.height, _rightButton.bounds.size.width, _rightButton.bounds.size.height)];
    [_rightButton addTarget:self.superview action:@selector(goRightDown:) forControlEvents:UIControlEventTouchDown];
    [_rightButton addTarget:self.superview action:@selector(goRightUp:) forControlEvents:UIControlEventTouchUpInside];

    
    _player = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player"]];
    [_player setFrame:CGRectMake(frame.size.width/2 - frame.size.width/15/2, frame.size.height - 20 - frame.size.width/15, frame.size.width/15, frame.size.width/15)];
       
    _asteroides = [[NSMutableArray alloc] init];
    _images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"asteroide-100-0%d", i+1]];
        [_images addObject:image];
        image = [UIImage imageNamed:[NSString stringWithFormat:@"asteroide-120-0%d", i+1]];
        [_images addObject:image];
    }
    
    
    [self addSubview:_prefButton];
    [self addSubview:_levelLabel];
    [_levelLabel release];
    [self addSubview:_scoreButton];
    [self addSubview:_currentScoreLabel];
    [_currentScoreLabel release];
    [self addSubview:_player];
    [_player release];
    [self addSubview:_leftButton];
    [self addSubview:_rightButton];
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_prefButton dealloc];
    [_scoreButton dealloc];
    [_levelLabel dealloc];
    [_leftButton dealloc];
    [_rightButton dealloc];
    [_player dealloc];
    [_images dealloc];
    [_asteroides dealloc];
    [_timerAsteroide dealloc];
    [_currentScoreLabel dealloc];
}

- (void) activeTimerAsteroide{
    _timerAsteroide = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(addAsteroides:) userInfo:nil repeats:true];
}

- (void) disableTimerAsteroide{
    [_timerAsteroide invalidate];
    _timerAsteroide = nil;
}

- (void) addAsteroides:(NSTimer *) t{
    CGRect frame = self.frame;
    
    for (int i = 0; i < _level*2; ++i){
        int random = arc4random() % 8;
        UIImage *image = [_images objectAtIndex:random];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        random = arc4random() % (int) roundf(frame.size.width);
        
        if (random > (frame.size.width - frame.size.width/15)){
            random = frame.size.width - frame.size.width/15;
        }
        
        [imageView setFrame:CGRectMake(random, 20, frame.size.width/15, frame.size.height/15)];
        
        random = (arc4random() % (int) roundf(frame.size.height))/200;
        
        if (random == 0){
            random += 2;
        }
        
        NSMutableArray *dict = [NSMutableArray arrayWithObjects: [NSString stringWithFormat:@"%d",random*_level],imageView, [NSString stringWithFormat:@"%f", 0.0], [NSString stringWithFormat:@"%u", arc4random() % 100], nil];
        [_asteroides addObject:dict];
        [self addSubview:imageView];
        [imageView release];
    }
}

- (void) reset{
    CGRect frame = self.frame;
    
    _currentScore = 0;
    
    [_currentScoreLabel setText:@"0"];
    [_currentScoreLabel sizeToFit];
    [_currentScoreLabel setFrame:CGRectMake(frame.size.width/2 - _currentScoreLabel.bounds.size.width/2, 20 + _scoreButton.bounds.size.height+5, _currentScoreLabel.bounds.size.width, _currentScoreLabel.bounds.size.height)];
    
    [_player setFrame:CGRectMake(frame.size.width/2 - frame.size.width/15/2, frame.size.height - 20 - frame.size.width/15, frame.size.width/15, frame.size.width/15)];
    
    for (int i = 0; i < _asteroides.count; ++i){
        NSArray *array = [_asteroides objectAtIndex:i];
        UIImageView *imageView = [array objectAtIndex:1];
        [imageView removeFromSuperview];
    }
    
    [_leftButton setEnabled:true];
    [_rightButton setEnabled:true];
    
    [_player setTransform:CGAffineTransformMakeRotation(0)];

    [_asteroides removeAllObjects];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_prefButton setFrame:CGRectMake(size.width - _prefButton.bounds.size.width - 20, 20, _prefButton.bounds.size.width, _prefButton.bounds.size.height)];
    [_scoreButton setFrame:CGRectMake(size.width/2 - _scoreButton.bounds.size.width/2, 20, _scoreButton.bounds.size.width, _prefButton.bounds.size.height)];
    
   [_currentScoreLabel setFrame:CGRectMake(size.width/2 - _currentScoreLabel.bounds.size.width/2, 20 + _scoreButton.bounds.size.height+5, _currentScoreLabel.bounds.size.width, _currentScoreLabel.bounds.size.height)];
    
    [_levelLabel setFrame:CGRectMake(20, 20, _levelLabel.bounds.size.width, _prefButton.bounds.size.height)];
    
    [_leftButton setFrame:CGRectMake(20, size.height - 10 - _leftButton.bounds.size.height, _leftButton.bounds.size.width, _leftButton.bounds.size.height)];
    
    [_rightButton setFrame:CGRectMake(size.width - 20 - _rightButton.bounds.size.width, size.height - 10 - _rightButton.bounds.size.height, _rightButton.bounds.size.width, _rightButton.bounds.size.height)];
    
     [_player setFrame:CGRectMake(size.width/2 - size.width/15/2, size.height - 20 - size.width/15, size.width/15, size.width/15)];
}

- (void) refreshScore{
    CGRect frame = self.bounds;

    [_currentScoreLabel setText:[NSString stringWithFormat:@"%d", _currentScore]];
    [_currentScoreLabel sizeToFit];
    [_currentScoreLabel setFrame:CGRectMake(frame.size.width/2 - _currentScoreLabel.bounds.size.width/2, 20 + _scoreButton.bounds.size.height+5, _currentScoreLabel.bounds.size.width, _currentScoreLabel.bounds.size.height)];
}


- (void) setLevel:(NSInteger ) l{
    CGRect frame = self.bounds;
    _level = l;
    [_levelLabel setText:[NSString stringWithFormat:@"Level %ld", (long)_level]];
    _levelLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_levelLabel setTextColor:[UIColor whiteColor]];
    [_levelLabel setTextAlignment:NSTextAlignmentCenter];
    [_levelLabel sizeToFit];
    [_levelLabel setFrame:CGRectMake(20, 20, _levelLabel.bounds.size.width, _prefButton.bounds.size.height)];
    [self setNeedsDisplay];
}

- (void) enableButton{
    [_leftButton setEnabled:true];
    [_rightButton setEnabled:true];
}

- (void) disableButton{
    [_leftButton setEnabled:false];
    [_rightButton setEnabled:false];
}

@end






















