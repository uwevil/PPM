//
//  ViewController.swift
//  Rouletabille
//
//  Created by Cao Sang DOAN on 29/11/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var myView: MyView?
    var compteur = 0
    var screenTimer: NSTimer?
    var timer: NSTimer?
    var time = 59
    var isFirstTap = true
    
    let motionManager = CMMotionManager()
    
    var currentX = 0.0
    var currentY = 0.0
    var hitWall = true
    
    var audioBackGround: AVAudioPlayer?
    var audioGameOver: AVAudioPlayer?
    var audioWall: AVAudioPlayer?
    var audioStar: AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
       if (motionManager.deviceMotionAvailable && motionManager.gyroAvailable){
            myView = MyView(frame: UIScreen.mainScreen().bounds)
            self.view = myView
            
            let tapDetect = UITapGestureRecognizer(target: self, action: "tapDetector:")
            tapDetect.numberOfTapsRequired = 1
            self.view.addGestureRecognizer(tapDetect)
            
            var audioFile = String(format: "%@/son.bundle/Ruth.mp3", NSBundle.mainBundle().resourcePath!)
    
            var audioURL = NSURL(fileURLWithPath: audioFile)
            audioBackGround = AVAudioPlayer(contentsOfURL: audioURL, error: nil)
            
            audioFile = String(format: "%@/son.bundle/son.mp3", NSBundle.mainBundle().resourcePath!)
            audioURL = NSURL(fileURLWithPath: audioFile)
            audioWall = AVAudioPlayer(contentsOfURL: audioURL, error: nil)
            
            audioFile = String(format: "%@/son.bundle/squeeze.mp3", NSBundle.mainBundle().resourcePath!)
            audioURL = NSURL(fileURLWithPath: audioFile)
            audioStar = AVAudioPlayer(contentsOfURL: audioURL, error: nil)

            audioFile = String(format: "%@/son.bundle/son-etoile.mp3", NSBundle.mainBundle().resourcePath!)
            audioURL = NSURL(fileURLWithPath: audioFile)
            audioGameOver = AVAudioPlayer(contentsOfURL: audioURL, error: nil)
        
            audioBackGround?.delegate = self
     //       audioBackGround?.play()

            self.becomeFirstResponder()
        }else{
            let alert = UIAlertView(title: "Gyromètre manqué", message: "Votre mobile ne supporte pas cette application", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
       }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        compteur = (compteur + 1) % 4
        myView?.setFond(compteur)
    }
    
    override func motionCancelled(motion: UIEventSubtype, withEvent event: UIEvent) {
    }
    
    func refreshScreen(){
        if (motionManager.deviceMotion == nil){
            return
        }
        
        print(String(format: "roll : %4.4f\npitch : %4.4f\nyaw : %4.4f", arguments:
            [motionManager.deviceMotion!.attitude.roll, motionManager.deviceMotion!.attitude.pitch, motionManager.deviceMotion!.attitude.yaw]))
        
        let x = motionManager.deviceMotion!.gravity.x
        let y = motionManager.deviceMotion!.gravity.y
        let h = UIScreen.mainScreen().bounds.height
        let w = UIScreen.mainScreen().bounds.width

        currentX = x*20 + currentX
        currentY = -y*20 + currentY
        
        myView?.updateBille(CGPointMake(CGFloat(currentX), CGFloat(currentY)))
        
        if ((Int(myView!.bille.center.x) == Int(w - myView!.bille.bounds.width/2) || Int(myView!.bille.center.x) == Int(myView!.bille.bounds.width/2) || Int(myView!.bille.center.y) == Int(h - myView!.bille.bounds.height/2) || Int(myView!.bille.center.y) == Int(myView!.bille.bounds.height/2))){
            if (hitWall){
                audioWall?.play()
                hitWall = false
            }
        }else{
            hitWall = true
        }
        
        let currentEtoileX = myView!.etoile!.center.x
        let currentEtoileY = myView!.etoile!.center.y
        let wE = myView!.etoile!.bounds.width
        let hE = myView!.etoile!.bounds.height
        let wB = myView!.bille.bounds.width
        let hB = myView!.bounds.height
        
        let tmpX1 = Int(currentX) + Int(wB/2)
        let tmpY1 = Int(currentY) + Int(wB/2)
        
        let tmpX2 = Int(currentX) - Int(wB/2)
        let tmpY2 = Int(currentY) - Int(wB/2)
        
        if ((tmpX1 <= Int(currentEtoileX) + Int(wE/2)) && (tmpX1 >= Int(currentEtoileX) - Int(wE/2)) && (tmpY1 <= Int(currentEtoileY) + Int(hE/2)) && (tmpY1 >= Int(currentEtoileY) - Int(hE/2))){
            compteur++
            audioStar?.play()
            myView?.scoreLabel?.text = "\(compteur)"
            myView?.randomEtoile()
        }else if ((tmpX2 <= Int(currentEtoileX) + Int(wE/2)) && (tmpX2 >= Int(currentEtoileX) - Int(wE/2)) && (tmpY2 <= Int(currentEtoileY) + Int(hE/2)) && (tmpY2 >= Int(currentEtoileY) - Int(hE/2))){
            compteur++
            audioStar?.play()
            myView?.scoreLabel?.text = "\(compteur)"
            myView?.randomEtoile()
        }
    }
    
    func refreshTime(){
        myView?.setTime(time)
        time = time - 1
        if (time <= 0){
            screenTimer?.invalidate()
            timer?.invalidate()
            time = 59
            myView?.setTime(61)
            
            currentX = Double(UIScreen.mainScreen().bounds.width/2)
            currentY = Double(UIScreen.mainScreen().bounds.height/2)
            
            myView?.scoreLabel?.text = ""
            motionManager.startDeviceMotionUpdates()
            motionManager.stopAccelerometerUpdates()
            
            audioGameOver?.play()
            myView?.gameOver(compteur)
            
            compteur = 0
            isFirstTap = true
        }
    }
    
    func tapDetector(g: UITapGestureRecognizer){
        if (isFirstTap){
            myView!.gameOver?.removeFromSuperview()
            myView!.gameOver = nil
            myView!.message.hidden = true
            myView!.etoile?.hidden = false
            myView!.bille.hidden = false
            
            screenTimer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: "refreshScreen", userInfo: nil, repeats: true)
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "refreshTime", userInfo: nil, repeats: true)
            
            motionManager.startDeviceMotionUpdates()
            motionManager.startAccelerometerUpdates()
            motionManager.accelerometerUpdateInterval = 0.002
            myView?.start()
            currentX = Double(UIScreen.mainScreen().bounds.width/2)
            currentY = Double(UIScreen.mainScreen().bounds.height/2)
            
            isFirstTap = false
        }
    }
    

}















