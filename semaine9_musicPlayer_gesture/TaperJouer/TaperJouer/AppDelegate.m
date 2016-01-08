//
//  AppDelegate.m
//  TaperJouer
//
//  Created by Cao Sang DOAN on 30/11/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicViewController.h"
#import "HistoryViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    MusicViewController *myMusic = [[MusicViewController alloc] init];
    HistoryViewController *history = [[HistoryViewController alloc] init];
    
    [myMusic setHistoryViewController:history];
    [myMusic initHistory];
    
    [history setMyMusicController:myMusic];
    
    UINavigationController *myMusicNav = [[UINavigationController alloc] initWithRootViewController:myMusic];
    
    UINavigationController *historyNav = [[UINavigationController alloc] initWithRootViewController:history];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] scale] != 3.0){
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        tabBarController.viewControllers = [[NSArray alloc] initWithObjects:myMusic, historyNav, nil];
        _window.rootViewController = tabBarController;
        [_window makeKeyAndVisible];
        [historyNav release];
    }else{
        UISplitViewController *mySplit = [[UISplitViewController alloc] init];
        mySplit.viewControllers = [[NSArray alloc] initWithObjects:historyNav, myMusicNav, nil];
        [mySplit setDelegate:historyNav];
        
        [myMusic setMySplit:mySplit];
        [history setMySplit:mySplit];
        
        [_window setRootViewController:mySplit];
        [mySplit setPreferredDisplayMode:UISplitViewControllerDisplayModeAutomatic];
        [[[myMusicNav topViewController] navigationItem] setLeftBarButtonItem:[mySplit displayModeButtonItem]];
        [_window makeKeyAndVisible];
        
        [mySplit release];
    }
    
    [myMusic release];
    [history release];
    
    [myMusicNav release];
    [historyNav release];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
