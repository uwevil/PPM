//
//  ViewController.swift
//  TestUIActivityIndicatorView
//
//  Created by Cao Sang DOAN on 17/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var indicator: UIActivityIndicatorView?
    private var button: UIButton?
    private var ok = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = UIScreen.mainScreen().bounds
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        indicator?.sizeToFit()
        indicator?.frame = CGRectMake(frame.width/2 - indicator!.frame.width/2, frame.height/2, indicator!.bounds.width, indicator!.bounds.height)

        button = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        button!.setTitle("Indicator", forState: .Normal)
        button!.sizeToFit()
        button!.frame = CGRectMake(frame.width/2 - button!.frame.width/2, frame.height/4, button!.frame.width, button!.frame.height)
        
        button?.addTarget(self, action: "change:", forControlEvents: UIControlEvents.TouchDown)
        
        self.view.addSubview(indicator!)
        self.view.addSubview(button!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func change(sender: UIButton){
        if !ok {
            indicator?.startAnimating()
            ok = true
        }else{
            indicator?.stopAnimating()
            ok = false
        }
    }
    

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        indicator?.frame = CGRectMake(size.width/2 - indicator!.frame.width/2, size.height/2, indicator!.bounds.width, indicator!.bounds.height)
        button?.frame = CGRectMake(size.width/2 - button!.frame.width/2, size.height/4, button!.frame.width, button!.frame.height)

    }
}

