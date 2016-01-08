//
//  MyMusic.h
//  
//
//  Created by Cao Sang DOAN on 01/12/15.
//
//

#import <UIKit/UIKit.h>

@interface MyMusic : UIView

@property(readwrite, nonatomic, retain) UILabel *status;
@property(readwrite, nonatomic, retain) UITextView *songNameLabel;
@property(readwrite, nonatomic, retain) UIProgressView *progressBar;
@property(readwrite, nonatomic, retain) UILabel *songOrder;

- (void) reposition:(CGSize) size;
- (void) setCurrentSong:(int) currentSong andTotal: (int) total;
- (void) setNowPlaying:(NSString *)name;
- (void) setStatusLabel:(NSString *)s;

@end
