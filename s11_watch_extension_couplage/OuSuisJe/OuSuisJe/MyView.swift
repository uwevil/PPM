//
//  MyView.swift
//  
//
//  Created by Cao Sang DOAN on 15/12/15.
//
//

import UIKit
import CoreLocation


class MyView: UIView, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
                
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.distanceFilter = 1.0
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }else{
            let alert = UIAlertView(title: "Erreur", message: "Localisation déactivée", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        
        var locationArray = locations as NSArray
        let cllocation = locationArray.lastObject! as! CLLocation
        
        userLocation = cllocation.coordinate
        print(locationArray.description)

    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        let alert = UIAlertView(title: "Erreur", message: "Localisation anormalie", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        locationManager.stopUpdatingLocation()
        print("failll\n")
    }
}
