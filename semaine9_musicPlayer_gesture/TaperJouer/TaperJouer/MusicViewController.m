//
//  MasterViewController.m
//  
//
//  Created by Cao Sang DOAN on 30/11/15.
//
//

#import "MusicViewController.h"

@implementation MusicViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *icon = [UIImage imageNamed:@"toto"];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Music" image:icon tag:0];
        self.tabBarItem = tabBarItem;
        _myMusic = [[MyMusic alloc] init];
        self.view = _myMusic;
        
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetector:)];
        [_tap setNumberOfTapsRequired:2];
        [[self view] addGestureRecognizer:_tap];
        
        _next = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextDetector:)];
        [_next setDirection:UISwipeGestureRecognizerDirectionLeft];
        [[self view] addGestureRecognizer:_next];
        
        _back = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backDetector:)];
        [_back setDirection:UISwipeGestureRecognizerDirectionRight];
        [[self view] addGestureRecognizer:_back];
        
        _myMusicPlayer = [MPMusicPlayerController systemMusicPlayer];
        [_myMusicPlayer setRepeatMode:MPMusicRepeatModeAll];
        
        _songQuery = [MPMediaQuery songsQuery];
        
        [_myMusicPlayer setQueueWithQuery:_songQuery];
        [_myMusicPlayer setShuffleMode:MPMusicShuffleModeOff];
        
        _isPlaying = false;
        _currentSong = 1;
        _total = [[_songQuery collections] count];
        
        [_myMusic setCurrentSong:_currentSong andTotal:_total];
        
        [tabBarItem release];
        [_myMusic release];
        [_tap release];
        [_next release];
        [_back release];
        
    }
    return self;
}

-(void) dealloc{
    [super release];
    
    [_mySplit release];
    [_historyViewController release];
    [_songQuery release];
    [_next release];
    [_tap release];
    [_back release];
    [_myMusic release];
    [_myMusicPlayer release];
}

- (void)viewDidLoad{
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [_myMusic reposition:size];
}

- (void) tapDetector: (UITapGestureRecognizer *)sender{
    if (_total == 0){
        return;
    }
    if (!_isPlaying){
        _isPlaying = true;
        
        [_myMusicPlayer beginGeneratingPlaybackNotifications];
   //     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTrackChange) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
        [_myMusicPlayer play];
        MPMediaItem *song = [_myMusicPlayer nowPlayingItem];
        
        [_myMusic setCurrentSong:_currentSong andTotal:_total];
        [_myMusic setNowPlaying:[song valueForProperty:MPMediaItemPropertyTitle]];
        [_myMusic setStatusLabel:@"En écoute"];
        [_historyViewController addCell:song withIndex:_currentSong];
    }else{
        _isPlaying = false;
        
        [_myMusicPlayer pause];
        [_myMusicPlayer endGeneratingPlaybackNotifications];
        [_myMusic setStatusLabel:@"A l'arrêt"];
    }
}

/*
- (void) notifyTrackChange{
    MPMediaItem *song = [_myMusicPlayer nowPlayingItem];
    _currentSong = _currentSong + 1;
    if (_currentSong > _total){
        _currentSong = 1;
    }
    [_myMusic setCurrentSong:_currentSong andTotal:_total];
    [_myMusic setNowPlaying:[song valueForProperty:MPMediaItemPropertyTitle]];

    [_historyViewController addCell:song withIndex:_currentSong];
}
*/
- (void) nextDetector: (UISwipeGestureRecognizer *)sender{
    if (_total == 0){
        return;
    }
    _currentSong = _currentSong + 1;
    if (_currentSong > _total){
        _currentSong = 1;
    }
    
    [_myMusicPlayer skipToNextItem];
    MPMediaItem *song = [_myMusicPlayer nowPlayingItem];

    [_myMusic setCurrentSong:_currentSong andTotal:_total];
    [_myMusic setNowPlaying:[song valueForProperty:MPMediaItemPropertyTitle]];
    
    if (_isPlaying){
        [_myMusicPlayer play];
        [_historyViewController addCell:song withIndex:_currentSong];
    }else{
        [_myMusicPlayer pause];
    }
}

- (void) backDetector: (UISwipeGestureRecognizer *)sender{
    if (_total == 0){
        return;
    }
    _currentSong = (_currentSong - 1);
    
    if (_currentSong <= 0){
        _currentSong = _total;
    }
    
    [_myMusicPlayer skipToPreviousItem];
    MPMediaItem *song = [_myMusicPlayer nowPlayingItem];

    [_myMusic setCurrentSong:_currentSong andTotal:_total];
    [_myMusic setNowPlaying:[song valueForProperty:MPMediaItemPropertyTitle]];
    
    if (_isPlaying){
        [_myMusicPlayer play];
        [_historyViewController addCell:song withIndex:_currentSong];
    }else{
        [_myMusicPlayer pause];
    }
}

- (void) play:(MPMediaItem *) song withIndex:(int) index{
    if (_isPlaying){
        [_myMusicPlayer pause];
        _currentSong = index;

        [_myMusicPlayer setNowPlayingItem:song];
        [_myMusicPlayer play];
    }else{
        _isPlaying = true;
        _currentSong = index;
        
        [_myMusicPlayer beginGeneratingPlaybackNotifications];
        [_myMusicPlayer setNowPlayingItem:song];
        [_myMusicPlayer play];
    }
    
    [_myMusic setCurrentSong:_currentSong andTotal:_total];
    [_myMusic setNowPlaying:[song valueForProperty:MPMediaItemPropertyTitle]];
    [_myMusic setStatusLabel:@"En écoute"];
}

- (void) initHistory{
    [_historyViewController setTotal:_total];
}

@end










