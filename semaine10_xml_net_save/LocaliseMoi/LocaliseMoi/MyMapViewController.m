//
//  MyMapViewController.m
//  
//
//  Created by Cao Sang DOAN on 07/12/15.
//
//

#import "MyMapViewController.h"

@interface MyMapViewController ()

@end

@implementation MyMapViewController

-(id) init{
    [super init];
    
    UIView *v = [[UIView alloc] init];
//    [v setBackgroundColor:[UIColor blackColor]];
    
    [self setTitle:@"Navigation"];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"terre"] tag:0];
    [self setTabBarItem:item];
    
    _searchField = [[UITextField alloc] init];
    [_searchField setBackgroundColor:[UIColor whiteColor]];
    [_searchField setFont:[UIFont systemFontOfSize:15]];
    [_searchField setKeyboardType:UIKeyboardTypeWebSearch];
    [_searchField setKeyboardAppearance:UIKeyboardAppearanceLight];
    [_searchField setPlaceholder:@"Rechercher une addresse"];
    [_searchField setDelegate:self];
    
    [v addSubview:_searchField];
    [_searchField release];
    
    _map = [[MKMapView alloc] init];
    [_map setScrollEnabled:true];
    [_map setZoomEnabled:true];
    [_map setPitchEnabled:true];
    [_map setDelegate:self];
    [v addSubview:_map];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"Plan", @"Satellite", @"Hydrid", nil];
    _mapTypeSegment = [[UISegmentedControl alloc] initWithItems:array];
    [_mapTypeSegment addTarget:self action:@selector(mapTypeChange:) forControlEvents:UIControlEventValueChanged];
    [v addSubview:_mapTypeSegment];
    
    [self reDraw:[[UIScreen mainScreen] bounds].size];
    
    [self setView:v];
    [v release];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIUserNotificationSettings *autorisation = [[UIApplication sharedApplication] currentUserNotificationSettings];
    
    if (autorisation.types == UIUserNotificationTypeNone){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Echec" message:@"Notification désactivée" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void)dealloc
{
    [super dealloc];
    
    [_mySplitViewController release];
    [_tableViewController release];
    
    [_searchField release];
    [_mapTypeSegment release];
    [_map release];
    
    [_data release];
    [_query release];
}

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] scale] != 3.0){
        [self reDraw:size];
    }
}

- (void) reDraw: (CGSize)size{
    CGFloat y = 70;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] scale] != 3.0){
        if (size.width < size.height){
            y = 70;
        }else{
            y = size.height/8;
        }
    }
    CGFloat w = size.width;
    CGFloat h = size.height - y;

    [_searchField setFrame:CGRectMake(5, y, w - 10, h/19)];
    [_mapTypeSegment setFrame:CGRectMake(w/2 - _mapTypeSegment.bounds.size.width/2, y + 20 + _searchField.bounds.size.height, _mapTypeSegment.bounds.size.width, _mapTypeSegment.bounds.size.height)];
    [_map setFrame:CGRectMake(0, y + _searchField.bounds.size.height + 5, w, h - 5 - _searchField.bounds.size.height)];
    
}

- (void) mapTypeChange: (UISegmentedControl *) sender{
    switch (_mapTypeSegment.selectedSegmentIndex) {
        case 1:
            [_map setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [_map setMapType:MKMapTypeHybrid];
            break;
        default:
            [_map setMapType:MKMapTypeStandard];
            break;
    }
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    [_searchField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if ([_searchField.text length] == 0){
        [_searchField resignFirstResponder];
        return false;
    }
    
    unichar tmp = [_searchField.text characterAtIndex:_searchField.text.length-1];
    if ([[NSString stringWithCharacters:&tmp length:1] isEqualToString:@" "]){
        _searchField.text = [_searchField.text substringToIndex:_searchField.text.length - 1];
    }
    
    _query = [[_searchField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"] copy];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/xml?address=%@&sensor=false", _query]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:true];

    _data = [[NSMutableData alloc] init];
    
    [request release];
    
    [_searchField setText:nil];
    [_searchField setPlaceholder:@"Rechercher une addresse"];
    [_searchField resignFirstResponder];
    return true;
}

-(BOOL) textFieldShouldClear:(UITextField *)textField{
    return true;
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Echec" message:@"Connection impossible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
  //  NSString *result = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
 //   NSLog(result);
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:_data];
    [parser setDelegate:self];

    if (![parser parse]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Echec" message:@"Parser impossible" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

-(void) parserDidStartDocument:(NSXMLParser *)parser{
    _isFirstLat = false;
    _isFirstLng = false;
    _isFirstLocation = false;
    _isFirstParser = true;
    _lat = -1;
    _lng = -1;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser{
    if (_lat == _lng && _lng == -1) {
        return;
    }
    
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(_lat, _lng);
    [_map setRegion:MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)) animated:true];
    
    NSString *tmp = [[_query stringByReplacingOccurrencesOfString:@"+" withString:@" "] copy];

    [_tableViewController addHistory:tmp withLat: _lat andWithLng: _lng];
    
    UIApplication *app = [UIApplication sharedApplication];
    UILocalNotification *localNot = [[UILocalNotification alloc] init];
    [localNot setAlertAction:@"Recherche"];
    [localNot setAlertBody:tmp];
    [localNot setApplicationIconBadgeNumber:[app applicationIconBadgeNumber]+1];
    [localNot setUserInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"Notifie", @"IDkey", nil]];
    [localNot setSoundName:UILocalNotificationDefaultSoundName];
    [app presentLocalNotificationNow:localNot];
    
    
    _isFirstLat = false;
    _isFirstLng = false;
    _isFirstLocation = false;
    _isFirstParser = true;
    [parser release];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{

    if (!_isFirstParser){
        return;
    }
    
    if ([elementName isEqualToString:@"location"] && !_isFirstLocation){
        _isFirstLocation = true;
    }
    
    if ([elementName isEqualToString:@"lat"] && !_isFirstLat){
        _isFirstLat = true;
    }
    
    if ([elementName isEqualToString:@"lng"] && !_isFirstLng){
        _isFirstLng = true;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (_isFirstLocation){
        if (_isFirstLat){
            _lat = [string floatValue];
            _isFirstLat = false;
        }
    
        if (_isFirstLng){
            _lng = [string floatValue];
            _isFirstLng = false;
            _isFirstLocation = false;
            _isFirstParser = false;
        }
    }
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
}

-(void) goHistory:(float) lat andLng: (float) lng{
    CLLocationCoordinate2D loc = CLLocationCoordinate2DMake(lat, lng);
    [_map setRegion:MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.1, 0.1)) animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
