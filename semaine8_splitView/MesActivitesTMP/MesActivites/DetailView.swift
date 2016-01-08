//
//  DetailView.swift
//  
//
//  Created by Cao Sang DOAN on 24/11/15.
//
//

import UIKit

class DetailView: UIView, UITextFieldDelegate, UIScrollViewDelegate {
    var background: UIImageView?
    var titleLabel: UILabel?
    var titleText: UITextField?
    var priorityLabel: UILabel?
    var segment: UISegmentedControl?
    private var image: UIImage?
    var imageView: UIImageView?
    var scrollView: UIScrollView?
    
    var detailController: DetailViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        background = UIImageView(image: UIImage(named: "fond-alu"))
        
        titleLabel = UILabel()
        titleLabel?.text = "Titre"
        titleLabel?.textColor = UIColor.blackColor()
        titleLabel?.sizeToFit()
        
        titleText = UITextField()
        titleText?.borderStyle = UITextBorderStyle.Bezel
        titleText?.textAlignment = NSTextAlignment.Left
        titleText?.delegate = self
        
        priorityLabel = UILabel()
        priorityLabel?.text = "Priorité"
        priorityLabel?.textColor = UIColor.blackColor()
        priorityLabel?.sizeToFit()
       
        segment = UISegmentedControl(items: ["0", "1", "2", "3", "4"])
        segment?.selectedSegmentIndex = 0
        segment?.addTarget(self.superview, action: "segmentSelected:", forControlEvents: UIControlEvents.ValueChanged)
        
        scrollView = UIScrollView()
        scrollView?.maximumZoomScale = 1
        scrollView?.minimumZoomScale = 0.01
        scrollView?.zoomScale = 1
        scrollView?.delegate = self
        
        
        self.addSubview(background!)
        self.addSubview(titleLabel!)
        self.addSubview(titleText!)
        self.addSubview(priorityLabel!)
        self.addSubview(segment!)
        self.addSubview(scrollView!)

       reposition(frame.size)
    
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPrio(p: Int){
        segment?.selectedSegmentIndex = p
        setNeedsDisplay()
    }

    func setTextField(s:String){
        titleText?.text = s
        setNeedsDisplay()
    }
    
    func reposition(size: CGSize){
        let y = size.height/10;
        titleLabel?.frame = CGRectMake(10, y, titleLabel!.bounds.width, titleLabel!.bounds.height)
        titleText?.frame = CGRectMake(titleLabel!.bounds.width + 20, y, size.width - 10*3 - titleLabel!.bounds.width, 30)
        
        priorityLabel?.frame = CGRectMake(10, y + 20 + titleText!.frame.height, priorityLabel!.frame.width, priorityLabel!.frame.height)
        segment?.frame = CGRectMake(10, y + 20*2 + titleText!.frame.height + priorityLabel!.frame.height, size.width - 10*2, segment!.frame.height)
        
        scrollView!.frame = CGRectMake(10, y + 20*3 + titleText!.frame.height + priorityLabel!.frame.height + segment!.bounds.size.height, size.width - 10*2, size.height - y - 20*3 - titleText!.frame.height + priorityLabel!.frame.height + segment!.bounds.size.height - 20)
        
        setNeedsDisplay()
    }
    
    func setImage(i: UIImage){
        image = i
        imageView = UIImageView(image: image)
        scrollView?.addSubview(imageView!)
        reposition(UIScreen.mainScreen().bounds.size)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.keyboardAppearance = UIKeyboardAppearance.Default
        textField.keyboardType = UIKeyboardType.Default
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (string == "\n"){
            detailController!.callViewController?.currentTitle = textField.text
            detailController!.callViewController?.refresh()
            textField.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        scrollView.zoomScale = scale
    }
    
}






