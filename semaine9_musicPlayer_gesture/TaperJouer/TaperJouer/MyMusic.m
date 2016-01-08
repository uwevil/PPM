//
//  MyMusic.m
//  
//
//  Created by Cao Sang DOAN on 01/12/15.
//
//

#import "MyMusic.h"
#import "UIKit/UIKit.h"

@implementation MyMusic

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _status = [[UILabel alloc] init];
        [_status setText:@"A l'arrêt"];
        [_status sizeToFit];
        
        _progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [_progressBar setBackgroundColor:[UIColor lightGrayColor]];
        [_progressBar setProgress:0];
        
        _songNameLabel = [[UITextView alloc] init];
        [_songNameLabel setSelectable:false];
        
        
        _songOrder = [[UILabel alloc] init];
        [_songOrder setText:@"0/0"];
        [_songOrder setTextAlignment:NSTextAlignmentCenter];
        
        [self addSubview:_status];
        [_status release];
        
        [self addSubview:_progressBar];
        [_progressBar release];
        
        [self addSubview:_songNameLabel];
        [_songNameLabel release];
        
        [self addSubview:_songOrder];
        [_songOrder release];
        
        [self reposition:[[UIScreen mainScreen] bounds].size];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_status release];
    [_progressBar release];
    [_songNameLabel release];
    [_songOrder release];
}

- (void) reposition:(CGSize) size{
    CGFloat w = size.width;
    CGFloat h = size.height;
    
    [_progressBar setFrame:CGRectMake(w/10, h/2, w - w/10*2, _progressBar.bounds.size.height)];
    [_songNameLabel setFrame:CGRectMake(w/10, h/4 - _progressBar.bounds.size.height*2, w - w/10*2, h/7)];
    [_status setFrame:CGRectMake(w/2 - _status.bounds.size.width/2, h/8, _status.bounds.size.width, _status.bounds.size.height)];
    [_songOrder setFrame:CGRectMake(w/2 - w/4/2, h - h/9*5 + h/15, w/4, _status.bounds.size.height)];
}

- (void) setCurrentSong:(int) currentSong andTotal: (int) total{
    [_songOrder setText:[[NSString alloc] initWithFormat:@"%d/%d", currentSong, total, nil]];
    [_songOrder setTextAlignment:NSTextAlignmentCenter];
    
    
    float f = (float)currentSong/(float)total;
    [_progressBar setProgress:f animated:true];
    
    [self setNeedsDisplay];
}

- (void) setNowPlaying:(NSString *)name{
    [_songNameLabel setText:name];
    [_songNameLabel setTextAlignment:NSTextAlignmentCenter];
    [self setNeedsDisplay];
}

- (void) setStatusLabel:(NSString *)s{
    [_status setText:s];
    [_status sizeToFit];
}

@end












