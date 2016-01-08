//
//  EslaveViewController.h
//  
//
//  Created by Cao Sang DOAN on 30/11/15.
//
//

#import <UIKit/UIKit.h>
#import "MusicViewController.h"

@interface HistoryViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate, UISplitViewControllerDelegate>

@property(nonatomic, strong) UISplitViewController *mySplit;
@property(nonatomic, strong) UIViewController *myMusicController;

@property(nonatomic, strong) NSMutableArray *arrayHistory;

- (void) setTotal:(int) t;

- (void) addCell:(MPMediaItem *)song withIndex:(int) index;

@end
