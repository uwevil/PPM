//
//  ViewController.swift
//  Imagier_Swift
//
//  Created by Cao Sang DOAN on 10/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    private var myView: MyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screen = UIScreen.mainScreen()
        myView = MyView(frame: screen.bounds)
        
        self.view = myView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        myView.viewWillTransitionToSize(size)
    }


}

