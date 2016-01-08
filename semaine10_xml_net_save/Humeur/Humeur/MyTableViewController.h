//
//  MyTableViewController.h
//  
//
//  Created by Cao Sang DOAN on 09/12/15.
//
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"

@interface MyTableViewController : UITableViewController <UINavigationControllerDelegate, NSNetServiceDelegate, NSNetServiceBrowserDelegate>

@property(readwrite, nonatomic, retain) UIViewController *myViewController;

@property(readwrite, nonatomic, retain) NSNetService *netService;
@property(readwrite, nonatomic, retain) NSNetServiceBrowser *netBrowser;

@property(readwrite, nonatomic, retain) NSString *name;
@property(readwrite, nonatomic, retain) NSString *status;

@property(readwrite, nonatomic, retain) NSMutableArray *arrayHistory;


-(void) refresh;

@end
