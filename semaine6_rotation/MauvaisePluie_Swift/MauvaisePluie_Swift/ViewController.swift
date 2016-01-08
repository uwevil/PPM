//
//  ViewController.swift
//  MauvaisePluie_Swift
//
//  Created by Cao Sang DOAN on 18/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var prefView: PrefView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let frame = UIScreen.mainScreen().bounds
        
        prefView = PrefView(frame: frame)
        
        self.view.addSubview(prefView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

