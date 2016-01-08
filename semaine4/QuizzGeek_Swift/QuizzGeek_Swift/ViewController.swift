//
//  ViewController.swift
//  QuizzGeek_Swift
//
//  Created by Cao Sang DOAN on 07/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let myView = MyView(frame: UIScreen.mainScreen().bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = myView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        myView.viewWillTransitionToSize(size)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
}

