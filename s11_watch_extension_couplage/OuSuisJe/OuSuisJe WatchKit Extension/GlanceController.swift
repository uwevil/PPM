//
//  GlanceController.swift
//  OuSuisJe WatchKit Extension
//
//  Created by Cao Sang DOAN on 14/12/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var bodyLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
