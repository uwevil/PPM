//
//  MyTableViewController.h
//  
//
//  Created by Cao Sang DOAN on 07/12/15.
//
//

#import <UIKit/UIKit.h>
#import "MyMapViewController.h"
#import "CoreLocation/CoreLocation.h"


@interface MyTableViewController : UITableViewController <UINavigationControllerDelegate, UISplitViewControllerDelegate>

@property(readwrite, nonatomic, retain) UISplitViewController *mySplitViewController;
@property(readwrite, nonatomic, retain) UIViewController *mapViewController;

@property(readwrite, nonatomic, retain) NSMutableArray *arrayHistory;

- (void) addHistory: (NSString *) address withLat:(float) lat andWithLng:(float) lng;
@end
