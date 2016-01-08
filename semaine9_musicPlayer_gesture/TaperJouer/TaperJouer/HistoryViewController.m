//
//  EslaveViewController.m
//  
//
//  Created by Cao Sang DOAN on 30/11/15.
//
//

#import "HistoryViewController.h"

@implementation HistoryViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1];
        self.tabBarItem = item;
        
        _arrayHistory = [[NSMutableArray alloc] init];
        
        CGFloat w = [[UIScreen mainScreen] bounds].size.width;
        CGFloat h = [[UIScreen mainScreen] bounds].size.height;
        
        [[self tableView] setFrame:CGRectMake(0, h/15, w, h - 2*h/15)];
        [[self tableView] setSeparatorColor:[UIColor blackColor]];
        [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        
        [[self tableView] setEditing:false];
        
        [[self tableView] setDataSource:self];
        [[self tableView] setDelegate:self];
        [self setTitle:@"Historique"];
        
        [[self navigationItem] setTitle:@"Historique"];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_arrayHistory release];
    [_myMusicController release];
    [_mySplit release];
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    UIEdgeInsets adjustForTabbarInsets = UIEdgeInsetsMake(0, 0, CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
    [[self tableView] setContentInset:adjustForTabbarInsets];
    [[self tableView] setScrollIndicatorInsets:adjustForTabbarInsets];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_arrayHistory count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    NSArray *a = [_arrayHistory objectAtIndex:indexPath.row];
    MPMediaItem *tmp = [a objectAtIndex:0];
    
    [[cell textLabel] setText:[tmp valueForProperty:MPMediaItemPropertyTitle]];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    
    int i = 0;
    for (i = 0; i < _arrayHistory.count; i++) {
        NSArray *a = [_arrayHistory objectAtIndex:i];
        MPMediaItem *tmp = [a objectAtIndex:0];
        if ([[tmp valueForProperty:MPMediaItemPropertyTitle] isEqualToString:[[cell textLabel] text]]){
            [_myMusicController play:tmp withIndex:[[a objectAtIndex:1] integerValue]];
        }
    }
}

- (void) setTotal:(int) t{
    _arrayHistory = [[NSMutableArray alloc] initWithCapacity:t];
}

- (void) addCell:(MPMediaItem *)song withIndex:(int) index{
    MPMediaItem *mediaTmp = nil;
    
    int i = 0;
    for (i = 0; i < _arrayHistory.count; i++){
        NSArray *a = [_arrayHistory objectAtIndex:i];
        MPMediaItem *tmp = [a objectAtIndex:0];
        if ([[tmp valueForProperty:MPMediaItemPropertyTitle] isEqualToString:[song valueForProperty:MPMediaItemPropertyTitle]]){
            mediaTmp = tmp;
        }
    }
    
    if (mediaTmp == nil){
           NSArray *array = [NSArray arrayWithObjects:song, [NSString stringWithFormat:@"%d", index, nil], nil];
        
        [_arrayHistory addObject:array];
        NSArray *tmp = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:[_arrayHistory count] - 1 inSection:0]];
        [[self tableView] insertRowsAtIndexPaths:tmp withRowAnimation:UITableViewRowAnimationAutomatic];
        UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[_arrayHistory count] - 1 inSection:0]];
        [[cell textLabel] setText:[song valueForProperty:MPMediaItemPropertyTitle]];
        [[self tableView] reloadData];
    }
}

- (UISplitViewControllerDisplayMode) targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        return  UISplitViewControllerDisplayModeAllVisible;
    }else{
        return  UISplitViewControllerDisplayModePrimaryOverlay;
    }
}

@end
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
                                                                          
