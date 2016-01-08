//
//  ViewController.swift
//  iSouvenir
//
//  Created by Cao Sang DOAN on 18/11/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var myView: MyView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myView = MyView(frame: UIScreen.mainScreen().bounds)
        myView?.myController = self
        self.view = myView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        myView!.positionner(size)
    }
    
}
