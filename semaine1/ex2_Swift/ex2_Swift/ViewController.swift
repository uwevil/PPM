//
//  ViewController.swift
//  ex2_Swift
//
//  Created by Cao Sang DOAN on 21/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var couleur: UIView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepper.minimumValue = 0
        stepper.maximumValue = 5
        stepper.stepValue = 1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func changeValue(sender: UIStepper) {
        
        switch (stepper.value)
        {
        case 0 : 
            couleur.backgroundColor = UIColor.yellowColor()
            break
        case 1:
            couleur.backgroundColor = UIColor.cyanColor()
            break;
        case 2 : 
            couleur.backgroundColor = UIColor.greenColor()
            break
        case 3 : 
            couleur.backgroundColor = UIColor.grayColor()
            break
        case 4 : 
            couleur.backgroundColor = UIColor.redColor()
            break
        case 5 : 
            couleur.backgroundColor = UIColor.purpleColor()
            break
        default :
            couleur.backgroundColor = UIColor.blueColor()
            break
        }

    }
}

