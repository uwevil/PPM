//
//  MyNavigationController.swift
//  
//
//  Created by Cao Sang DOAN on 25/11/15.
//
//

import UIKit

class MyNavigationController: UINavigationController {
    
    var myTable: MyTableViewController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        myTable = MyTableViewController(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Grouped)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
