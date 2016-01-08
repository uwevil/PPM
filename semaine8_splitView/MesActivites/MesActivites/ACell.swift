//
//  ACell.swift
//  
//
//  Created by Cao Sang DOAN on 23/11/15.
//
//

import UIKit

class ACell: NSObject {
    var label = ""
    var priority = 0
    var image: UIImage?
    
    init(l: String, p: Int){
        label = l
        priority = p
    }
}
