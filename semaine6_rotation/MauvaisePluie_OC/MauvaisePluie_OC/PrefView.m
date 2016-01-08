//
//  PrefView.m
//  
//
//  Created by Cao Sang DOAN on 18/10/15.
//
//

#import "PrefView.h"
#import "GameView.h"

@implementation PrefView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

NSArray *levelLabel;
NSInteger level;

- (id)initWithFrame:(CGRect)frame
{
    
    levelLabel  = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    [super initWithFrame:frame];
    
    [self setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5]];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"Done" forState: UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:frame.size.width/30];
    [_button sizeToFit];
    [_button addTarget:self.superview action:@selector(donePrefView:) forControlEvents:UIControlEventTouchDown];
    [_button setFrame:CGRectMake(frame.size.width - 20 - _button.bounds.size.width, 20, _button.bounds.size.width, _button.bounds.size.height)];
    
    _picker = [[UIPickerView alloc] init];
    [_picker selectRow:0 inComponent:0 animated:true];
    [_picker sizeToFit];
 //   [_picker setFrame:CGRectMake(frame.size.width/2 - _picker.bounds.size.width/2, frame.size.height/2 - _picker.bounds.size.height/2, _picker.bounds.size.width, _picker.bounds.size.height)];
    [_picker setDelegate:self];
    
    
 //   NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@{@"picker": _picker}, nil];
   
    NSLayoutConstraint *cH = [NSLayoutConstraint constraintWithItem:_picker attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.0];
    [_picker setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addConstraint:cH];
    
    NSLayoutConstraint *cV = [NSLayoutConstraint constraintWithItem:_picker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0];
    [_picker setTranslatesAutoresizingMaskIntoConstraints:false];
    [self addConstraint:cV];
    
    [_picker setDataSource:self];
    
    _label = [[UILabel alloc] init];
    [_label setText:@"Level 1"];
    [_label setFont:[UIFont systemFontOfSize:frame.size.width/30 ]];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [_label setTextColor:[UIColor yellowColor]];
    [_label sizeToFit];
    [_label setFrame:CGRectMake(frame.size.width/2 - _label.bounds.size.width/2,frame.size.height/5, _label.bounds.size.width, _label.bounds.size.height)];
    
    [self addSubview:_label];
    [_label release];
    [self addSubview:_button];
    [self addSubview:_picker];
    [_picker release];
    
    return  self;
}

- (void)dealloc{
    [super dealloc];
    
    [_label dealloc];
    [_button dealloc];
    [_picker dealloc];
    [levelLabel dealloc];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [levelLabel count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [levelLabel objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    level = row;
    [_label setText:[NSString stringWithFormat:@"Level %@", [levelLabel objectAtIndex:level]]];
    [_label setTextAlignment:NSTextAlignmentCenter];
    [_label setTextColor:[UIColor yellowColor]];
    [_label sizeToFit];
    [self setNeedsDisplay];
}

- (NSArray *) getLevelLabel{
    return levelLabel;
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self setFrame:CGRectMake(0, 0, size.width, size.height)];
    [_button setFrame:CGRectMake(size.width - 20 - _button.bounds.size.width, 20, _button.bounds.size.width, _button.bounds.size.height)];
 //   [_picker setFrame:CGRectMake(size.width/2 - _picker.bounds.size.width/2, size.height/2 - _picker.bounds.size.height/2, _picker.bounds.size.width, _picker.bounds.size.height)];
    [_label setFrame:CGRectMake(size.width/2 - _label.bounds.size.width/2,size.height/5, _label.bounds.size.width, _label.bounds.size.height)];
}

-(NSInteger) getLevel{
    return level;
}

@end









