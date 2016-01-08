//
//  MyTableViewController.m
//  
//
//  Created by Cao Sang DOAN on 07/12/15.
//
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (id) initWithStyle:(UITableViewStyle)style{
    [super initWithStyle:style];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *buttonBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = buttonBarItem;
    
    [self setTitle:@"Historique"];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1];
    [self setTabBarItem:item];
    
    _arrayHistory = [[NSMutableArray alloc] init];

    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    return  self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_mySplitViewController release];
    [_mapViewController release];
    
    [_arrayHistory release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    
    NSString *path = [[dir objectAtIndex:0] stringByAppendingPathComponent:@"backup"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]){
        _arrayHistory = [[NSKeyedUnarchiver unarchiveObjectWithFile:path] retain];
        
        int i;
        for (i = 0; i < _arrayHistory.count; i++){
            NSArray *array = [_arrayHistory objectAtIndex:i];
            NSString *title = [array objectAtIndex:0];
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSArray *tmp = [NSArray arrayWithObject:indexPath];
            
            [cell.textLabel setText:title];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@",[array objectAtIndex:1], [array objectAtIndex:2]]];
            [self.tableView insertRowsAtIndexPaths:tmp withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    
    NSArray *tmp = [_arrayHistory objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:[tmp objectAtIndex:0]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@",[tmp objectAtIndex:1], [tmp objectAtIndex:2]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_arrayHistory removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    int from = (int)fromIndexPath.row;
    int to = (int)toIndexPath.row;
    
    NSArray *tmpFrom = [_arrayHistory objectAtIndex:from];

    if (from < to){
        [_arrayHistory insertObject:tmpFrom atIndex:to+1];
        [_arrayHistory removeObjectAtIndex:from];
    }else if (from > to){
        [_arrayHistory insertObject:tmpFrom atIndex:to];
        [_arrayHistory removeObjectAtIndex:from+1];
    }
    
    [tableView reloadData];
}

- (void) addHistory: (NSString *) address withLat:(float) lat andWithLng:(float) lng{
    int i;
    for (i = 0; i < _arrayHistory.count; i++) {
        NSArray *array = [_arrayHistory objectAtIndex:i];
        NSString *title = [array objectAtIndex:0];
        if ([[title uppercaseString] isEqualToString:[address uppercaseString]]){
            return;
        }
    }
    
    NSArray *array = [NSArray arrayWithObjects:address, [NSString stringWithFormat:@"%f", lat], [NSString stringWithFormat:@"%f", lng], nil];
    
    [_arrayHistory addObject:array];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_arrayHistory count] - 1 inSection:0];
    NSArray *tmp = [NSArray arrayWithObject:indexPath];
    
    [[self tableView] insertRowsAtIndexPaths:tmp withRowAnimation:UITableViewRowAnimationAutomatic];
   
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    
    [cell.textLabel setText:[array objectAtIndex:0]];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@, %@",[array objectAtIndex:1], [array objectAtIndex:2]]];
    
    [[self tableView] reloadData];

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = [_arrayHistory objectAtIndex:indexPath.row];
    [_mapViewController goHistory:[[array objectAtIndex:1] floatValue] andLng:[[array objectAtIndex:2] floatValue]];
    
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertAction:@"History"];
    [localNot setAlertBody:[array objectAtIndex:0]];
    [localNot setApplicationIconBadgeNumber:[app applicationIconBadgeNumber]+1];
    [localNot setUserInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"Notifie", @"IDkey", nil]];
    [localNot setSoundName:UILocalNotificationDefaultSoundName];
    [app presentLocalNotificationNow:localNot];
    

}

-(void) save: (UIBarButtonItem *)sender{
    NSArray *dir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    
    NSString *path = [[dir objectAtIndex:0] stringByAppendingPathComponent:@"backup"];
    
    BOOL res = [NSKeyedArchiver archiveRootObject:_arrayHistory toFile:path];
    if (res == false){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Echec" message:@"Sauvegarde impossible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
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


























