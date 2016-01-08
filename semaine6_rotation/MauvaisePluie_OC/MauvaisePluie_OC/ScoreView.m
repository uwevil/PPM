//
//  ScoreView.m
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import "ScoreView.h"

@implementation ScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

NSMutableArray *tableScoreLabel;

-(id) initWithFrame:(CGRect)frame{
    [super initWithFrame:frame];
    
    _currentScore = 0;
    
    [self setBackgroundColor:[UIColor colorWithRed:0.3 green:0.5 blue:0.8 alpha:0.4]];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"Done" forState: UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_button sizeToFit];
    [_button addTarget:self.superview action:@selector(doneScoreView:) forControlEvents:UIControlEventTouchDown];
    [_button setFrame:CGRectMake(frame.size.width - 20 - _button.bounds.size.width, 20, _button.bounds.size.width, _button.bounds.size.height)];
    
    _labelName1 = [[UILabel alloc] init];
    [_labelName1 setText:@"Meilleures scores"];
    [_labelName1 setTextColor:[UIColor whiteColor]];
    _labelName1.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_labelName1 sizeToFit];
    [_labelName1 setFrame:CGRectMake(frame.size.width/2 - _labelName1.bounds.size.width/2, 20, _labelName1.bounds.size.width, _button.bounds.size.height)];
    
    _score = [[NSMutableArray alloc] init];
    tableScoreLabel = [[NSMutableArray alloc] init];
    
    UILabel *labelTmp = nil;
    
    for (int i = 0; i < 5; ++i) {
        NSArray *dict = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)_currentScore], @"???", nil];
        [_score insertObject:dict atIndex:i];
        
        labelTmp = [[UILabel alloc] init];
        [labelTmp setText:@"??? : 0"];
        [labelTmp setTextColor:[UIColor whiteColor]];
        [labelTmp setTextAlignment:NSTextAlignmentCenter];
        [labelTmp sizeToFit];
        [labelTmp setFrame:CGRectMake(frame.size.width/2 - labelTmp.bounds.size.width/2, 20 + _labelName1.bounds.size.height + i*labelTmp.bounds.size.height + 5*i , labelTmp.bounds.size.width, labelTmp.bounds.size.height)];
        [tableScoreLabel insertObject:labelTmp atIndex:i];
        [self addSubview:labelTmp];
        [labelTmp release];
    }
    
    _currentScoreLabel = [[UILabel alloc] init];
    [_currentScoreLabel setText:[NSString stringWithFormat:@"%ld", (long)_currentScore ]];
    [_currentScoreLabel setTextColor:[UIColor cyanColor]];
    _currentScoreLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_currentScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [_currentScoreLabel sizeToFit];
    [_currentScoreLabel setFrame:CGRectMake(frame.size.width/2 - _currentScoreLabel.bounds.size.width*2,  20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10, _currentScoreLabel.bounds.size.width*4, _currentScoreLabel.bounds.size.height)];
    
    _labelName2 = [[UILabel alloc] init];
    [_labelName2 setText:@"Votre score"];
    [_labelName2 setTextColor:[UIColor whiteColor]];
    _labelName2.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_labelName2 sizeToFit];
    [_labelName2 setFrame:CGRectMake(frame.size.width/2 - _labelName2.bounds.size.width/2, 20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10 + _currentScoreLabel.bounds.size.height, _labelName2.bounds.size.width, _button.bounds.size.height)];
    
    _nameField = [[UITextField alloc] init];
    [_nameField setText:@""];
    _nameField.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_nameField setBackgroundColor:[UIColor whiteColor]];
    
    [_nameField setFrame:CGRectMake(frame.size.width/2 - frame.size.width/5/2, 20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10 + _currentScoreLabel.bounds.size.height + _labelName2.bounds.size.height + 5, frame.size.width/5, 20)];
    [_nameField setDelegate:self];
    [_nameField setKeyboardType:UIKeyboardTypeASCIICapable];
    [_nameField setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [_nameField setReturnKeyType:UIReturnKeyDone];

    [self addSubview:_button];
    [self addSubview:_labelName1];
    [_labelName1 release];
    [self addSubview:_labelName2];
    [_labelName2 release];
    [self addSubview:_nameField];
    [_nameField release];
    [self addSubview:_currentScoreLabel];
    [_currentScoreLabel release];
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [tableScoreLabel dealloc];
    [_labelName1 dealloc];
    [_labelName2 dealloc];
    [_score dealloc];
    [_labelScore dealloc];
    [_currentScoreLabel dealloc];
    [_button dealloc];
    [_nameField dealloc];
}

- (void) reset{    
    _currentScore = 0;
    [_currentScoreLabel setText:@"0"];
    [_currentScoreLabel setTextColor:[UIColor cyanColor]];
    [_currentScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [_currentScoreLabel sizeToFit];

}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_button setFrame:CGRectMake(size.width - 20 - _button.bounds.size.width, 20, _button.bounds.size.width, _button.bounds.size.height)];
    [_labelName1 setFrame:CGRectMake(size.width/2 - _labelName1.bounds.size.width/2, 20, _labelName1.bounds.size.width, _button.bounds.size.height)];
    
    UILabel *labelTmp = nil;
    
    for (int i = 0; i < 5; ++i) {
        labelTmp = [tableScoreLabel objectAtIndex:i];
        [labelTmp setFrame:CGRectMake(size.width/2 - labelTmp.bounds.size.width/2, 20 + _labelName1.bounds.size.height + i*labelTmp.bounds.size.height + 5*i , labelTmp.bounds.size.width, labelTmp.bounds.size.height)];
    }
    
    [_currentScoreLabel setFrame:CGRectMake(size.width/2 - _currentScoreLabel.bounds.size.width*2,  20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10, _currentScoreLabel.bounds.size.width*4, _currentScoreLabel.bounds.size.height)];
    
    [_labelName2 setFrame:CGRectMake(size.width/2 - _labelName2.bounds.size.width/2, 20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10 + _currentScoreLabel.bounds.size.height, _labelName2.bounds.size.width, _button.bounds.size.height)];
    
    [_nameField setFrame:CGRectMake(size.width/2 - size.width/5/2, 20 + _labelName1.bounds.size.height + 5*5 + 5*labelTmp.bounds.size.height + 10 + _currentScoreLabel.bounds.size.height + _labelName2.bounds.size.height + 5, size.width/5, 20)];
}

- (void) setScore:(NSString *) name andScore:(NSInteger ) s{
    
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ){
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    CGRect frame = self.frame;
    if ([string  isEqual: @"\n"]){
        
        UILabel *labelTmp = nil;
        
        for (int i = 0; i < _score.count; ++i) {
            NSArray *dict = [_score objectAtIndex:i];
            if ([[dict objectAtIndex:0] integerValue] <= _currentScore){
                dict = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)_currentScore], _nameField.text, nil];
                [_score insertObject:dict atIndex:i];
                
                labelTmp = [[UILabel alloc] init];
                [labelTmp setText:[NSString stringWithFormat:@"%@ : %ld", _nameField.text, (long)_currentScore]];
                [labelTmp setTextColor:[UIColor whiteColor]];
                [labelTmp setTextAlignment:NSTextAlignmentCenter];
                [labelTmp sizeToFit];
                [labelTmp setFrame:CGRectMake(frame.size.width/2 - labelTmp.bounds.size.width/2, 20 + _labelName1.bounds.size.height + i*labelTmp.bounds.size.height + 5*i , labelTmp.bounds.size.width, labelTmp.bounds.size.height)];
                
                [self addSubview:labelTmp];
                [tableScoreLabel insertObject:labelTmp atIndex:i];
                break;
            }
        }
        
        for (int i = 0; i < 5; ++i) {
            labelTmp = [tableScoreLabel objectAtIndex:i];
            [labelTmp setFrame:CGRectMake(frame.size.width/2 - labelTmp.bounds.size.width/2, 20 + _labelName1.bounds.size.height + i*labelTmp.bounds.size.height + 5*i , labelTmp.bounds.size.width, labelTmp.bounds.size.height)];
        }
     
        if (tableScoreLabel.count > 5){
                labelTmp = [tableScoreLabel objectAtIndex:5];
                [labelTmp removeFromSuperview];
                [tableScoreLabel removeObjectAtIndex:5];
                
                [_score removeObjectAtIndex:5];
        }
        
        _nameField.text = @"";
        [_nameField setEnabled:false];
        _nameField.hidden = true;
        [_nameField resignFirstResponder];
        return false;
    }
    return true;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        if([[UIScreen mainScreen] scale] != 3.0){
            [self setFrame:CGRectMake(0, - self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
        }else{
            [self setFrame:CGRectMake(0, - self.frame.size.height/3.2, self.frame.size.width, self.frame.size.height)];
        }
    }
}


@end
