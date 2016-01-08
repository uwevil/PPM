//
//  MyMapViewController.h
//  
//
//  Created by Cao Sang DOAN on 07/12/15.
//
//

#import <UIKit/UIKit.h>
#import "MyTableViewController.h"
#import "CoreLocation/CoreLocation.h"
#import "MapKit/MapKit.h"

@interface MyMapViewController : UIViewController <MKMapViewDelegate,
                                                    UINavigationControllerDelegate,
                                                    UITextFieldDelegate,
                                                    NSURLConnectionDelegate,
                                                    NSURLConnectionDataDelegate,
                                                    NSXMLParserDelegate
>

@property(readwrite, nonatomic, retain) UISplitViewController *mySplitViewController;
@property(readwrite, nonatomic, retain) UITableViewController *tableViewController;

@property(readwrite, nonatomic, retain) UITextField *searchField;
@property(readwrite, nonatomic, retain) UISegmentedControl *mapTypeSegment;
@property(readwrite, nonatomic, retain) MKMapView *map;

@property(readwrite, nonatomic, retain) NSMutableData *data;
@property(readwrite, nonatomic) BOOL isFirstParser;
@property(readwrite, nonatomic) BOOL isFirstLocation;
@property(readwrite, nonatomic) BOOL isFirstLng;
@property(readwrite, nonatomic) BOOL isFirstLat;
@property(readwrite, nonatomic, copy) NSString * query;

@property(readonly, nonatomic) float lng;
@property(readonly, nonatomic) float lat;

-(void) goHistory:(float) lat andLng: (float) lng;


@end
