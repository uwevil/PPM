//
//  AppDelegate.h
//  LocaliseMoi
//
//  Created by Cao Sang DOAN on 07/12/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMapViewController.h"
#import "MyTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) MyMapViewController *map;
@property(strong, nonatomic) MyTableViewController *table;



@end

