//
//  MasterViewController.h
//  
//
//  Created by Cao Sang DOAN on 30/11/15.
//
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"
#import "MyMusic.h"
#import "HistoryViewController.h"

@interface MusicViewController : UIViewController <MPMediaPickerControllerDelegate>

@property(nonatomic, strong) UISplitViewController *mySplit;
@property(nonatomic, strong) UITableViewController *historyViewController;

@property(nonatomic, strong) MyMusic *myMusic;

@property(readwrite, nonatomic, strong) MPMusicPlayerController *myMusicPlayer;
@property(readwrite, nonatomic, strong) MPMediaQuery *songQuery;

@property(readwrite, nonatomic, strong) UITapGestureRecognizer *tap;
@property(readwrite, nonatomic, strong) UISwipeGestureRecognizer *next;
@property(readwrite, nonatomic, strong) UISwipeGestureRecognizer *back;


@property(readwrite, nonatomic) int currentSong;
@property(readwrite, nonatomic) int total;

@property(readwrite, nonatomic) bool isPlaying;

- (void) play:(MPMediaItem *) song withIndex:(int) index;

- (void) initHistory;



@end
