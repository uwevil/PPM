//
//  AppDelegate.swift
//  MesActivites
//
//  Created by Cao Sang DOAN on 23/11/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
      
        let tableViewController = MyTableViewController(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        let navigationController = UINavigationController(rootViewController: tableViewController)
        
        tableViewController.navigation = navigationController
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

       /*
        var mySplit = MySplitViewController()
        var master = MyTableViewController(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
        var detail = DetailViewController()
        
        master.splitView = mySplit
        mySplit.masterViewController = master
        
        detail.splitView = mySplit
        mySplit.detailViewController = detail
        
        master.detail = detail
        detail.callViewController = master
        
        var masterNavigation = UINavigationController(rootViewController: master)
        var detailNavigation = UINavigationController(rootViewController: detail)
        
        master.navigation = masterNavigation
        
        mySplit.viewControllers = [masterNavigation, detailNavigation]
        mySplit.delegate = master
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone && UIScreen.mainScreen().scale != 3.0){
            var viewController = UIViewController()
            viewController.view.addSubview(mySplit.view)
            
            var traitCollection = UITraitCollection(verticalSizeClass: UIUserInterfaceSizeClass.Compact)

            viewController.setOverrideTraitCollection(traitCollection, forChildViewController: mySplit)
            
            mySplit.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
            self.window?.rootViewController = viewController
        }else{
            self.window?.rootViewController = mySplit
            mySplit.preferredDisplayMode = UISplitViewControllerDisplayMode.Automatic
            
            if (UIScreen.mainScreen().bounds.size.width < UIScreen.mainScreen().bounds.size.height){
                
                detailNavigation.topViewController.navigationItem.leftBarButtonItem = mySplit.displayModeButtonItem()
                detailNavigation.topViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
        self.window?.makeKeyAndVisible()
        */
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

