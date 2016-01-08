//
//  MyView.swift
//  
//
//  Created by Cao Sang DOAN on 29/11/15.
//
//

import UIKit

class MyView: UIView {
    
    let fond0 = UIImageView(image: UIImage(named: "fond-0"))
    let fond1 = UIImageView(image: UIImage(named: "fond-1"))
    let fond2 = UIImageView(image: UIImage(named: "fond-2"))
    let fond3 = UIImageView(image: UIImage(named: "fond-3"))
    
    var timeLabel: UILabel?
    var iconEtoile: UIImageView?
    var scoreLabel: UILabel?
    
    var etoile: UIImageView?
    let bille = UIImageView(image: UIImage(named: "bille"))
    
    let message = UITextView()

    var gameOver: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeLabel = UILabel()
        timeLabel!.text = "1:00"
        timeLabel!.textColor = UIColor.whiteColor()
        timeLabel!.textAlignment = NSTextAlignment.Center
        
        etoile = UIImageView()
        let image = UIImage(named: "etoile")
        etoile!.image = image
        
        iconEtoile = UIImageView()
        iconEtoile!.image = image
        
        scoreLabel = UILabel()
        scoreLabel!.text = "0"
        scoreLabel!.textColor = UIColor.whiteColor()
        scoreLabel!.textAlignment = NSTextAlignment.Left
        
        reposition(frame.size)
        
        fond1.hidden = true
        fond2.hidden = true
        fond3.hidden = true
        
        message.text = "Ramassez un maximum d'étoile en 1 minuite\nBonne chance!\nTAP"
        message.editable = false
        message.textColor = UIColor.whiteColor()
        message.textAlignment = NSTextAlignment.Center
        message.backgroundColor = UIColor.blackColor()
        
        self.addSubview(fond0)
        self.addSubview(fond1)
        self.addSubview(fond2)
        self.addSubview(fond3)
        self.addSubview(timeLabel!)
        self.addSubview(iconEtoile!)
        self.addSubview(scoreLabel!)
        self.addSubview(etoile!)
        etoile!.hidden = true
        self.addSubview(bille)
        bille.hidden = true
        self.addSubview(message)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTime(t: Int){
        if (t == 61){
            timeLabel!.text = "1:00"
        }else if (t < 10){
            timeLabel!.text = "0:0\(t)"
        }else{
            timeLabel!.text = "0:\(t)"
        }

        timeLabel!.textAlignment = NSTextAlignment.Center

        self.setNeedsDisplay()
    }
    
    func reposition(size: CGSize){
        let w = size.width
        let h = size.height

        etoile!.frame = CGRectMake(0, 0, 50, 50)
        iconEtoile!.frame = CGRectMake(w-3*w/15, 0, w/15, w/15)

        scoreLabel?.font = UIFont(name: "Chalkduster", size: w/13)
        scoreLabel!.frame = CGRectMake(w-2*w/15 , 0, w/15*3, w/15)

        timeLabel!.font = UIFont(name: "Chalkduster", size: w/10)
        timeLabel!.frame = CGRectMake(w/2 - w/3/2 , 0, w/3, w/5)
        
        message.font = UIFont(name: "Papyrus", size: w/20)
        message.frame = CGRectMake(w/10, h/2 - h/5/2, w - 2*w/10, h/3)
        
        fond0.center = CGPointMake(w/2, h/2)
        fond1.center = CGPointMake(w/2, h/2)
        fond2.center = CGPointMake(w/2, h/2)
        fond3.center = CGPointMake(w/2, h/2)
    }
    
    func setFond(i: Int){
        switch(i){
        case 1:
            fond0.hidden = true
            fond1.hidden = false
            fond2.hidden = true
            fond3.hidden = true
        case 2:
            fond0.hidden = true
            fond1.hidden = true
            fond2.hidden = false
            fond3.hidden = true
        case 3:
            fond0.hidden = true
            fond1.hidden = true
            fond2.hidden = true
            fond3.hidden = false
        default:
            fond0.hidden = false
            fond1.hidden = true
            fond2.hidden = true
            fond3.hidden = true
        }
    }
    
    func start(){
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        bille.center = CGPointMake(w/2, h/2)
        bille.hidden = false
        scoreLabel!.text = "0"
        
        randomEtoile()   
        etoile?.hidden = false
    }
    
    func randomEtoile(){
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        
        while (true){
            var tmp = UInt32(w)
            let x = Int(arc4random_uniform(tmp))
            tmp = UInt32(h)
            let y = Int(arc4random_uniform(tmp))
            
            if ((Int(x) + Int(etoile!.bounds.width)/2 <= Int(w)) && (Int(x) - Int(etoile!.bounds.width)/2 >= 0) && (Int(y) + Int(etoile!.bounds.height)/2 <= Int(h)) && (Int(y) - Int(etoile!.bounds.height)/2 >= 0)){
                etoile?.center = CGPointMake(CGFloat(x), CGFloat(y))
                break
            }
        }
    }
    
    func updateBille(c: CGPoint){
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        
        var x = c.x
        var y = c.y
        if (x + bille.bounds.width/2 > w){
            x = w - bille.bounds.width/2
        }
        if (x - bille.bounds.width/2 < 0){
            x = bille.bounds.width/2
        }
        if (y + bille.bounds.height/2 > h){
            y = h - bille.bounds.height/2
        }
        if (y - bille.bounds.height/2 < 0){
            y = bille.bounds.height/2
        }
        
        bille.center = CGPointMake(x, y)
        self.setNeedsDisplay()
    }
    
    func updateEtoile(c: CGPoint){
        etoile?.center = c
        self.setNeedsDisplay()
    }
    
    func gameOver(s: Int){
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        gameOver = UIView()
        gameOver!.opaque = false
        gameOver!.frame = CGRectMake(w/2 - w/3/2 , h/2 - h/3/2, w/3, h/3)

        let score = UILabel()
        score.text = "\(s)"
        score.font = UIFont(name: "Chalkduster", size: w/10)
        score.sizeToFit()
        score.frame = CGRectMake(gameOver!.bounds.width/2 - score.bounds.width/2/2, 20, score.frame.width, score.frame.height)
        
        let image = UIImageView(image: UIImage(named: "refresh"))
        image.sizeToFit()
        image.frame = CGRectMake(gameOver!.bounds.width/2 - image.bounds.width/2, score.bounds.height*2, image.bounds.width, image.bounds.height)
        
        gameOver!.addSubview(image)
        gameOver!.addSubview(score)
        
        self.addSubview(gameOver!)
    }
}








