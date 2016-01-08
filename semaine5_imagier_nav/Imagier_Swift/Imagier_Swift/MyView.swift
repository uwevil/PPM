//
//  MyView.swift
//  
//
//  Created by Cao Sang DOAN on 10/10/15.
//
//

import UIKit

class MyView: UIView, UIScrollViewDelegate{

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    private let nextButton = UIButton.buttonWithType(.System) as! UIButton
    private let backButton = UIButton.buttonWithType(.System) as! UIButton
    private let nameLabel = UILabel()
    
    private let slider = UISlider()
    
    private var imageView: UIImageView?
    
    private let scrollView = UIScrollView()
    
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        nextButton.setTitle("Next", forState: UIControlState.Normal)
        nextButton.setTitle("", forState: UIControlState.Highlighted)
        nextButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        nextButton.sizeToFit()
        nextButton.addTarget(self, action: "changeValue:", forControlEvents: UIControlEvents.TouchDown)
        nextButton.frame = CGRectMake(frame.width - 20 - nextButton.bounds.width, 20, nextButton.bounds.width, nextButton.bounds.height)
       
        backButton.setTitle("Back", forState: UIControlState.Normal)
        backButton.setTitle("", forState: UIControlState.Highlighted)
        backButton.titleLabel?.font = UIFont.systemFontOfSize(20)
        backButton.sizeToFit()
        backButton.addTarget(self, action: "changeValue:", forControlEvents: UIControlEvents.TouchDown)
        backButton.frame = CGRectMake(20, 20, backButton.bounds.width, backButton.bounds.height)
        
        nameLabel.text = "photo-0"
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.sizeToFit()
        nameLabel.frame = CGRectMake(frame.width/2 - nameLabel.bounds.width/2, 20 + nameLabel.bounds.height/2, nameLabel.bounds.width, nameLabel.bounds.height)
        
        slider.minimumValue = 0.05
        slider.maximumValue = 1.0
        
        slider.frame = CGRectMake(20, frame.height - 20 - slider.bounds.height, frame.width - 20*2, slider.bounds.height)
        slider.addTarget(self, action: "changeValueSlider:", forControlEvents: UIControlEvents.ValueChanged)
        
        scrollView.maximumZoomScale = 1.0
        scrollView.minimumZoomScale = 0.0
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.frame = CGRectMake(20, 20 + nextButton.frame.height, frame.width - 20*2, frame.height - nextButton.bounds.height - 20*2)
        
        let imageName = String(format: "%@/%@%d.jpg", NSBundle.mainBundle().resourcePath!, "imagier.bundle/photo-", currentIndex)
                
        imageView = UIImageView(image: UIImage(contentsOfFile: imageName));
        let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        effectX.minimumRelativeValue = -50
        effectX.maximumRelativeValue = 50
        let effectY = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        effectY.minimumRelativeValue = -50
        effectY.maximumRelativeValue = 50
        imageView?.addMotionEffect(effectX)
        imageView?.addMotionEffect(effectY)
        scrollView.addSubview(imageView!)
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            scrollView.setZoomScale(0.1, animated: true)
            slider.value = 0.1
        }else{
            scrollView.setZoomScale(0.3, animated: true)
            slider.value = 0.3
        }
        
        self.addSubview(scrollView)
        self.addSubview(slider)
        self.addSubview(nameLabel)
        self.addSubview(nextButton)
        self.addSubview(backButton)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewWillTransitionToSize(frame: CGSize){
        nextButton.frame = CGRectMake(frame.width - 20 - nextButton.bounds.width, 20, nextButton.bounds.width, nextButton.bounds.height)
        backButton.frame = CGRectMake(20, 20, backButton.bounds.width, backButton.bounds.height)
        nameLabel.frame = CGRectMake(frame.width/2 - nameLabel.bounds.width/2, 20 + nameLabel.bounds.height/2, nameLabel.bounds.width, nameLabel.bounds.height)
        
        slider.frame = CGRectMake(20, frame.height - 20 - slider.bounds.height, frame.width - 20*2, slider.bounds.height)
        
        scrollView.frame = CGRectMake(20, 20 + nextButton.frame.height, frame.width - 20*2, frame.height - nextButton.bounds.height - 20*2)
        

    }
    
    func changeValue(sender: UIButton){
        if (sender === nextButton){
            let currentImageTmp = currentIndex
            currentIndex = (currentIndex + 1) % 19
            
            imageView?.removeFromSuperview()
        }else{
            if (currentIndex == 0){
                currentIndex = 19
            }else{
                currentIndex = (currentIndex - 1) % 19
            }
            
            imageView?.removeFromSuperview()
        }
        
        let imageName = String(format: "%@/%@%d.jpg", NSBundle.mainBundle().resourcePath!, "imagier.bundle/photo-", currentIndex)
        
      //  println(imageName)
        
        imageView = UIImageView(image: UIImage(contentsOfFile: imageName));
        
        let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        effectX.minimumRelativeValue = -50
        effectX.maximumRelativeValue = 50
        let effectY = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        effectY.minimumRelativeValue = -50
        effectY.maximumRelativeValue = 50
        imageView?.addMotionEffect(effectX)
        imageView?.addMotionEffect(effectY)
        
        scrollView.addSubview(imageView!)
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            scrollView.setZoomScale(0.1, animated: true)
            slider.value = 0.1
        }else{
            scrollView.setZoomScale(0.3, animated: true)
            slider.value = 0.3
        }

        nameLabel.text = String(format: "photo-%d", currentIndex)
        nameLabel.textAlignment = .Center
        nameLabel.sizeToFit()
        nameLabel.frame = CGRectMake(frame.width/2 - nameLabel.bounds.width/2, 20 + nameLabel.bounds.height/2, nameLabel.bounds.width, nameLabel.bounds.height)
        
    }
    
    func changeValueSlider(sender: UIButton){
        scrollView.setZoomScale(CGFloat(slider.value), animated: true)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?{
        return imageView
    }

    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        scrollView.setZoomScale(scale, animated: true)
        slider.value = Float(scale)
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        slider.value = Float(scrollView.zoomScale)
    }
    
}
