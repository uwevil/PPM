//
//  ViewController.swift
//  Dizainier_Swift
//
//  Created by Cao Sang DOAN on 25/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var geekLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var dizaines: UISegmentedControl!
    @IBOutlet weak var unites: UISegmentedControl!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var switchButton: UISwitch!
    
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slider.minimumValue = 0
        slider.maximumValue = 99
        
        switchButton.setOn(false, animated: false)
        
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.stepValue = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeMode(sender: UISwitch) {
        affichage();
    }

    @IBAction func changeStepper(sender: UIStepper) {
        value = Int(stepper.value)
        affichage()
    }
    
    @IBAction func changeSegment(sender: UISegmentedControl) {
        value = Int(dizaines.selectedSegmentIndex * 10 + unites.selectedSegmentIndex)
        affichage()
    }

    
    @IBAction func changeSlider(sender: UISlider) {
        value = Int(slider.value)
        affichage()
    }
    
    @IBAction func changeReset(sender: UIButton) {
        value = 0
        affichage()
    }
    
    func affichage()
    {
        stepper.value = Double(value)
        dizaines.selectedSegmentIndex = value / 10
        unites.selectedSegmentIndex = value % 10
        slider.value = Float(value)
        
        if (switchButton.on)
        {
            geekLabel.text = "Geek"
            numberLabel.text = String(value, radix: 16)
        }
        else
        {
            geekLabel.text = "Normal"
            numberLabel.text = String(value, radix: 10)
        }
        
        let tmp = value % 10;
        
        switch (tmp) {
        case 1:
            numberLabel.textColor = UIColor.redColor()
            break
        case 2:
            numberLabel.textColor = UIColor.greenColor()
            break
        case 3:
            numberLabel.textColor = UIColor.grayColor()
            break
        case 4:
            numberLabel.textColor = UIColor.yellowColor()
            break
        case 5:
            numberLabel.textColor = UIColor.cyanColor()
            break
        case 6:
            numberLabel.textColor = UIColor.blackColor()
            break
        case 7:
            numberLabel.textColor = UIColor.purpleColor()
            break
        case 8:
            numberLabel.textColor = UIColor.magentaColor()
            break
        case 9:
            numberLabel.textColor = UIColor.orangeColor()
            break
        default:
            numberLabel.textColor = UIColor.blueColor()
            break
        }

    }
    
    
    
}

