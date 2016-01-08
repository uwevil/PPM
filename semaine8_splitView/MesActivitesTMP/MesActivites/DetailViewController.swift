//
//  DetailViewController.swift
//  
//
//  Created by Cao Sang DOAN on 23/11/15.
//
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var detailView: DetailView?
    var callViewController: MyTableViewController?
    var splitView: MySplitViewController?
    
    var imagePicker: UIImagePickerController?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        let camera = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: self, action: "takePhoto:")
        
        let library = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action: "library:")
        
        self.navigationItem.rightBarButtonItems = [camera, library]
        
        detailView = DetailView(frame: UIScreen.mainScreen().bounds)
        
        detailView?.detailController = self
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        
        self.navigationItem.title = "Détail"
        
        self.view = detailView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        detailView?.reposition(size)
    }
    
    func setViewController(m: MyTableViewController){
        callViewController = m
    }
    
    func setTitle1(s:String){
        detailView?.setTextField(s)
    }
    
    func setPriority(p:Int){
        detailView!.setPrio(p)
    }
    
    func setImage(i: UIImage){
        detailView?.setImage(i)
    }

    func segmentSelected(sender: UISegmentedControl){
        callViewController?.currentPrio = sender.selectedSegmentIndex
        callViewController?.refresh()
    }
    
    func takePhoto(sender: UIBarButtonItem){
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
            let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)
            imagePicker!.mediaTypes = mediaTypes!
            self.presentViewController(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func library(sender: UIBarButtonItem){
        imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker!, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        callViewController?.currentImage = image
        detailView?.setImage(image)
        callViewController?.refresh()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        imagePicker!.dismissViewControllerAnimated(true, completion: nil)
    }

    
}
