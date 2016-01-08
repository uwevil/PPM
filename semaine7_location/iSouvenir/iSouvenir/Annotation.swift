//
//  Pin.swift
//  
//
//  Created by Cao Sang DOAN on 16/11/15.
//
//

import UIKit
import CoreLocation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var photo: UIImage?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
}
