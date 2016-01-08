//
//  ViewController.swift
//  ex1_Swift
//
//  Created by Cao Sang DOAN on 21/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
   
    @IBOutlet weak var buttonLabel: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeValue(sender: UIButton) {
        if (buttonLabel.currentTitle == "Dis bonjour!")
        {
            label.text = "Bonjour!"
            buttonLabel.setTitle("Dis au revoir", forState: UIControlState.Normal)
        }
        else
        {
            label.text = "Au revoir!"
            buttonLabel.setTitle("Dis bonjour!", forState: UIControlState.Normal)
        }
    }

}

