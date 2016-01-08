//
//  MyView.swift
//  
//
//  Created by Cao Sang DOAN on 16/11/15.
//
//

import UIKit
import CoreLocation
import MapKit
import AddressBookUI

class MyView: UIView, CLLocationManagerDelegate, MKMapViewDelegate,
            ABPeoplePickerNavigationControllerDelegate,
            ABNewPersonViewControllerDelegate,
            ABPersonViewControllerDelegate,
            ABUnknownPersonViewControllerDelegate,
            UINavigationControllerDelegate,
            UIImagePickerControllerDelegate,
            UIScrollViewDelegate
{
    
    var myController: UIViewController?
    
    var segment: UISegmentedControl?
    var map: MKMapView?
    var mapCamera: MKMapCamera?
    var is3D = false
    
    var target: UIImageView?
    
    let locationManager = CLLocationManager()
    
    var regionPosition: CLLocationCoordinate2D?
    var userLocation: CLLocationCoordinate2D?
    
    var addPin: UIBarButtonItem?
    var trash: UIBarButtonItem?
    var flexibleSpace: UIBarButtonItem?
    var refresh: UIBarButtonItem?
    var bookmark: UIBarButtonItem?
    var camera: UIBarButtonItem?
    var library: UIBarButtonItem?

    let toolbar = UIToolbar()
    
    var count = 0
    
    var currentAnnotation: MKAnnotation?
    
    let abpicker = ABPeoplePickerNavigationController()
    var adnew: ABNewPersonViewController?
    
    let imagePicker = UIImagePickerController()

    var imageV: UIImageView?
    var scrollView: UIScrollView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        let array = [NSLocalizedString("plan", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), NSLocalizedString("satellite", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), NSLocalizedString("mix", tableName: "", bundle: NSBundle.mainBundle(), value: "", comment: ""), "3D"]
        
        segment = UISegmentedControl(items:array)
        segment!.backgroundColor = UIColor.whiteColor()
        segment?.selectedSegmentIndex = 0
        segment!.addTarget(self, action: "changeCarte:", forControlEvents: UIControlEvents.ValueChanged)
        
        if (CLLocationManager.locationServicesEnabled()){
            map = MKMapView(frame: frame)
            map?.scrollEnabled = true
            map?.zoomEnabled = true
            map?.pitchEnabled = true
            map?.delegate = self
            
            locationManager.distanceFilter = 1.0
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            
            target = UIImageView(image: UIImage(named: "target"))
            
            addPin = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPin:")
           
            trash = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "removePin:")
            trash!.enabled = false
            
            flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            
            refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: "refresh:")
           
            bookmark = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Bookmarks, target: self.superview, action: "bookmark:")
            bookmark!.enabled = false
           
            camera = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "takePhoto:")
            camera!.enabled = false
            
            library = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action: "library:")
            library!.enabled = false
            
            toolbar.items = [addPin!, trash!, flexibleSpace!, refresh!, bookmark!, camera!, library!]
            toolbar.barStyle = UIBarStyle.Default
            
            imagePicker.delegate = self
           
            self.addSubview(map!)
            self.addSubview(target!)
            self.addSubview(segment!)
            self.addSubview(toolbar)
            
            positionner(frame.size)
        }else{
            let alert = UIAlertView(title: "Erreur", message: "Localisation déactivée", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func positionner(size: CGSize){
        segment!.frame = CGRectMake(size.width/2 - segment!.bounds.width/2, 20, segment!.bounds.width, segment!.bounds.height)
        
        if (size.width > size.height){
            toolbar.frame = CGRectMake(0, size.height - size.width/19, size.width, size.width/19)
            
            if (scrollView != nil){
                map!.frame = CGRectMake(0, 0, size.width/2, size.height - size.height/19)
                scrollView!.frame = CGRectMake(size.width/2+2, 0, size.width/2 - 2, size.height - toolbar.frame.height)
                
                segment!.frame = CGRectMake(map!.frame.size.width/6, 20, 4*map!.frame.size.width/6, segment!.bounds.height)
            }else{
                map!.frame = CGRectMake(0, 0, size.width, (size.height - size.height/19))
            }
            
            target!.frame = CGRectMake(map!.bounds.width/2 - size.width/19/2, map!.bounds.height/2 - size.width/19/2, size.width/19, size.width/19)
        }else{
            toolbar.frame = CGRectMake(0, size.height - size.height/19, size.width, size.height/19)
            
            if (scrollView != nil){
                map!.frame = CGRectMake(0, 0, size.width, (size.height - size.height/19)/2)
                scrollView!.frame = CGRectMake(0, map!.frame.size.height+2, size.width, size.height - map!.frame.size.height - 2 - toolbar.frame.height)
            }else{
                map!.frame = CGRectMake(0, 0, size.width, (size.height - size.height/19))
            }
             target!.frame = CGRectMake(map!.bounds.width/2 - size.height/19/2, map!.bounds.height/2 - size.height/19/2, size.height/19, size.height/19)
        }
    }
    
    func addPin(sender: UIBarButtonItem){
        count = count + 1
        let pin = Annotation(coordinate: regionPosition!, title: String(format: "Contact %d", count), subtitle: "Pas de contact")
        map!.addAnnotation(pin)

    }
    
    func removePin(sender: UIBarButtonItem){
        map!.removeAnnotation(currentAnnotation)
    }
    
    func refresh(sender: UIBarButtonItem){
        let coord2D = userLocation!
        
        map!.setCenterCoordinate(coord2D, animated: true)
        map?.setNeedsDisplay()
    }
    
    func bookmark(sender: UIBarButtonItem){
        abpicker.peoplePickerDelegate = self
        myController?.presentViewController(abpicker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        myController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        
        var fn = ABRecordCopyValue(person, kABPersonFirstNameProperty)
        var ln = ABRecordCopyValue(person, kABPersonLastNameProperty)
        
        var name = ""
        
        if (fn != nil){
            name += fn.takeRetainedValue() as! String
            name += " "
        }
        
        if (ln != nil){
            name += ln.takeRetainedValue() as! String
        }
        
        var annotation = currentAnnotation as! Annotation
        annotation.subtitle = name

        print("person selected\n")
    }
    
    func personViewController(personViewController: ABPersonViewController!, shouldPerformDefaultActionForPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return false
    }
    
    func newPersonViewController(newPersonView: ABNewPersonViewController!, didCompleteWithNewPerson person: ABRecord!) {
        myController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func unknownPersonViewController(personViewController: ABUnknownPersonViewController!, shouldPerformDefaultActionForPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        return false
    }
    
    func unknownPersonViewController(unknownCardViewController: ABUnknownPersonViewController!, didResolveToPerson person: ABRecord!) {
        print("unknownPersonViewController\n")
    }
    
    func takePhoto(sender: UIBarButtonItem){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)
            imagePicker.mediaTypes = mediaTypes!
            myController?.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func library(sender: UIBarButtonItem){
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        myController?.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)

        var annotation = currentAnnotation as! Annotation
        annotation.photo = image
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation.isEqual(mapView.userLocation)){
            return nil
        }
        
        var pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ppm")
        pin.pinColor = MKPinAnnotationColor.Red
        pin.canShowCallout = true
        pin.leftCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
        
        return pin
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        trash!.enabled = true
        bookmark!.enabled = true
        camera!.enabled = true
        library!.enabled = true
        
        currentAnnotation = view.annotation
        
        print("pin selected\n")
    }
    
    func mapView(mapView: MKMapView!, didDeselectAnnotationView view: MKAnnotationView!) {
        trash!.enabled = false
        bookmark!.enabled = false
        camera!.enabled = false
        library!.enabled = false
        
        if (scrollView != nil){
            scrollView?.removeFromSuperview()
            scrollView = nil

            let current_frame = UIScreen.mainScreen().bounds

            positionner(current_frame.size)
        }
        
        print("pin deselected\n")
    }
    

    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var annotation = currentAnnotation as! Annotation
        
        if (annotation.photo != nil){
            imageV = UIImageView(image: annotation.photo)
            scrollView = UIScrollView()
            scrollView?.backgroundColor = UIColor.whiteColor()
            scrollView?.maximumZoomScale = 1.0
            scrollView?.minimumZoomScale = 0.05
            scrollView?.zoomScale = 0.05
            scrollView?.delegate = self
            scrollView?.addSubview(imageV!)
            
            self.addSubview(scrollView!)
            
            let current_frame = UIScreen.mainScreen().bounds
            positionner(current_frame.size)
        }
    }
    
    func changeCarte(seg: UISegmentedControl){
        switch (segment!.selectedSegmentIndex){
        case 0:
            map!.mapType = MKMapType.Standard
            is3D = false
            active3D()
        case 1:
            map!.mapType = MKMapType.Satellite
            is3D = false
            active3D()
        case 2:
            map!.mapType = MKMapType.Hybrid
            is3D = false
            active3D()
        case 3:
            map!.mapType = MKMapType.Standard
            is3D = true
            active3D()
        default:
            map!.mapType = MKMapType.Standard
            is3D = false
            active3D()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        
        var locationArray = locations as NSArray
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let cllocation = locationArray.lastObject! as! CLLocation
        
        userLocation = cllocation.coordinate
        
        let coord2D = cllocation.coordinate
        
        let region = MKCoordinateRegion(center: coord2D, span: span)
        
        map?.setRegion(region, animated: true)
        map?.setNeedsDisplay()
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        regionPosition = mapView.centerCoordinate
    }
    
    func active3D(){
        if (is3D){
            let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            
            let coord2D = regionPosition
            
            map!.showsBuildings = true

            mapCamera = MKMapCamera()
            mapCamera?.centerCoordinate = coord2D!
            mapCamera?.pitch = 45
            mapCamera?.altitude = 400
            mapCamera?.heading = 90
            map!.setCamera(mapCamera!, animated: true)
        }else{
            map!.showsBuildings = false
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        let alert = UIAlertView(title: "Erreur", message: "Localisation anormalie", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        
        locationManager.stopUpdatingLocation()
        print("failll\n")
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageV
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        scrollView.zoomScale = scale
    }

    
}
