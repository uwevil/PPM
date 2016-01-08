//
//  MyTableViewController.m
//  
//
//  Created by Cao Sang DOAN on 09/12/15.
//
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        UIBarButtonItem *buttonBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(changeStatus:)];
        self.navigationItem.rightBarButtonItem = buttonBarItem;
        
        [self setTitle:@"Humeurs"];
        
        NSUserDefaults *preference = [NSUserDefaults standardUserDefaults];
        
        if ([preference stringForKey:@"name"] == nil){
            _name = @"NoName";
        }else{
            _name = [preference stringForKey:@"name"];
        }
        
        _status = @"Happy";

        NSMutableArray *array = [[NSMutableArray alloc] init];
        [array insertObject:_name atIndex:0];
        [array insertObject:_status atIndex:1];
        
        _arrayHistory = [[NSMutableArray alloc] init];
        [_arrayHistory addObject:array];
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        
        [cell.textLabel setText:_name];
        [cell.detailTextLabel setText:@"Happy"];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0] ]withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView setEditing:false];
        
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        
        _netService = [[NSNetService alloc] initWithDomain:@"local" type:@"_humeur._tcp." name:_name port:9090];
        [_netService setDelegate:self];
        [_netService setIncludesPeerToPeer:true];
        
        NSData *data = [_status dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSDictionary dictionaryWithObject:data forKey:@"status"];
        
        NSData *d = [NSNetService dataFromTXTRecordDictionary:dict];
        [_netService setTXTRecordData:d];
        [_netService publish];
        [_netService startMonitoring];
        
        _netBrowser = [[NSNetServiceBrowser alloc] init];
        [_netBrowser setDelegate:self];
        [_netBrowser searchForServicesOfType:@"_humeur._tcp." inDomain:@"local"];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    
    [_myViewController release];
    
    [_netService release];
    [_netBrowser release];
    
    [_name release];
    [_status release];
    
    [_arrayHistory release];
}

- (void) refresh{
    NSMutableArray *array = [_arrayHistory objectAtIndex:0];
    if (![_name isEqualToString:[array objectAtIndex:0]]){
        [array replaceObjectAtIndex:0 withObject:_name];
    }

    if (![_status isEqualToString:[array objectAtIndex:1]]){
        [array replaceObjectAtIndex:1 withObject:_status];
    }

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
    [cell.textLabel setText:_name];
    [cell.detailTextLabel setText:_status];
    
    [self.tableView reloadData];
   
    NSData *data = [_status dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:data forKey:@"status"];
    NSData *d = [NSNetService dataFromTXTRecordDictionary:dict];
    [_netService setTXTRecordData:d];
}

- (void) netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data{
    
    NSDictionary *dict = [NSNetService dictionaryFromTXTRecordData:data];
    NSData *data2 = [dict objectForKey:@"status"];
  
    if (data2){
        NSString *name = [sender name];
        NSString *status = [[NSString alloc] initWithData:data2 encoding:NSUTF8StringEncoding];
        int i;

        for (i = 0; i < _arrayHistory.count; i++) {
            NSMutableArray *array = [_arrayHistory objectAtIndex:i];
            if ([[array objectAtIndex:0] isEqualToString:name]){
                [array replaceObjectAtIndex:1 withObject:status];
                break;
            }
        }
        [self.tableView reloadData];
    }
}

- (void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing{
    if ([[aNetService type] compare:@"_humeur._tcp."] == NSOrderedSame){
        if (![[aNetService name] compare:_name] == NSOrderedSame){
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSString *name = [aNetService name];
           
            [array insertObject:name atIndex:0];
            [array insertObject:@"Happy" atIndex:1];
            
            [_arrayHistory addObject:array];
            [self.tableView reloadData];
            [_netService startMonitoring];
        }
    }
}

- (void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing{
    NSString *name = [aNetService name];
    
    int i;
    for (i = 0; i < _arrayHistory.count; i++) {
        NSMutableArray *array = [_arrayHistory objectAtIndex:i];
        if ([[array objectAtIndex:0] isEqualToString:name]){
            [_arrayHistory removeObjectAtIndex:i];
            break;
        }
    }
    [self.tableView reloadData];
}

- (void) netServiceWillPublish:(NSNetService *)sender{}
- (void) netServiceWillResolve:(NSNetService *)sender{}
- (void) netServiceDidStop:(NSNetService *)sender{}
- (void) netServiceDidResolveAddress:(NSNetService *)sender{}
- (void) netServiceDidPublish:(NSNetService *)sender{}
- (void) netService:(NSNetService *)sender didAcceptConnectionWithInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream{}
- (void) netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict{}
- (void) netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict{}

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

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
    
    NSMutableArray *array = [_arrayHistory objectAtIndex:indexPath.row];
    [cell.textLabel setText:[array objectAtIndex:0]];
    [cell.detailTextLabel setText:[array objectAtIndex:1]];
    
    return cell;
}


-(void) changeStatus: (UIBarButtonItem *) sender{
    [self.navigationController pushViewController:_myViewController animated:true];
}

@end
