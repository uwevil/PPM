//
//  AppDelegate.h
//  Humeur
//
//  Created by Cao Sang DOAN on 09/12/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyViewController.h"
#import "MyTableViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) MyViewController *myView;
@property(strong, nonatomic) MyTableViewController *myTable;

@end

