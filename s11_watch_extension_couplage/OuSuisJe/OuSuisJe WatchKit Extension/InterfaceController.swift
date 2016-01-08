//
//  InterfaceController.swift
//  OuSuisJe WatchKit Extension
//
//  Created by Cao Sang DOAN on 14/12/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var latLabel: WKInterfaceLabel!
    @IBOutlet weak var lngLabel: WKInterfaceLabel!
    @IBOutlet weak var imageV: WKInterfaceImage!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        let parentValues = [
            "lat" : "",
            "lng" : ""
        ]
        WKInterfaceController.openParentApplication(parentValues, reply: { (replyValues, error) -> Void in
            let lat = replyValues["lat"]
            let lng = replyValues["lng"]
            
            self.latLabel.setText("Latitude \(lat)")
            self.lngLabel.setText("Longtitude \(lng)")
        })
        
        imageV.setImageNamed("watch")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func infoAction() {
        self.presentControllerWithName("info", context: nil)
    }
}
