//
//  MyView.swift
//  QuizzGeek_Swift
//
//  Created by Cao Sang DOAN on 07/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    private let device = UIDevice.currentDevice()
    private var nextButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    private var previousButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    private var responseButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
    private var questionLabel = UILabel()
    private var responseLabel = UILabel()
    private var seenLabel = UILabel()
    private var geekSwitch = UISwitch()
    
    private var questionView = UITextView()
    private var responseView = UITextView()

    private var seen = 0
    
    private var currentQuestion = 0
    private var (level, question, response, isSeen) = (false, "", "", false)
    private var questionTab = QuestionsReponses()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.whiteColor()
        
        nextButton.setBackgroundImage(UIImage(named: "next"), forState: UIControlState.Normal)
        nextButton.setBackgroundImage(UIImage(named: "in_action"), forState: UIControlState.Highlighted)
        nextButton.sizeToFit()
        nextButton.addTarget(self, action:"nextQuestion:", forControlEvents: UIControlEvents.TouchUpInside)
        
        previousButton.setBackgroundImage(UIImage(named: "back"), forState: UIControlState.Normal)
        previousButton.setBackgroundImage(UIImage(named: "in_action"), forState: UIControlState.Highlighted)
        previousButton.sizeToFit()
        previousButton.addTarget(self, action:"previousQuestion:", forControlEvents: UIControlEvents.TouchUpInside)

        
        responseButton.setTitle("Réponse", forState: UIControlState.Normal)
        responseButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        responseButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        responseButton.titleLabel?.font = UIFont(name: "System", size: 20)
        responseButton.sizeToFit()
        responseButton.addTarget(self, action:"getResponse:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        questionLabel.text = "Question"
        questionLabel.font = UIFont(name: "System", size: 20);
        questionLabel.textColor = UIColor.blackColor()
        questionLabel.sizeToFit()
        
        questionView.editable = false
        questionView.textColor = UIColor.blueColor()
        (level, question, response, isSeen) = questionTab.getQuizz(0)
        questionView.text = question
        questionView.textAlignment = NSTextAlignment.Center

        responseLabel.text = "Réponse"
        responseLabel.font = UIFont(name: "System", size: 20);
        responseLabel.textColor = UIColor.blackColor()
        responseLabel.sizeToFit()
        
        responseView.editable = false

        seenLabel.text = "Réponses vues: 0"
        seenLabel.textColor = UIColor.redColor()
        seenLabel.sizeToFit()
        
        geekSwitch.on = false
        geekSwitch.addTarget(self, action:"changeMode:", forControlEvents: UIControlEvents.AllTouchEvents)

        
        self.addSubview(nextButton)
        self.addSubview(previousButton)
        self.addSubview(responseButton)
        self.addSubview(questionLabel)
        self.addSubview(responseLabel)
        self.addSubview(seenLabel)
        self.addSubview(geekSwitch)

        self.addSubview(questionView)
        self.addSubview(responseView)

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        println("drawRect")
        nextButton.frame = CGRectMake(rect.width - nextButton.bounds.width - 20, 20, nextButton.frame.width, nextButton.bounds.height)
        
        previousButton.frame = CGRectMake(20, 20, previousButton.frame.width, previousButton.bounds.height)
        
       
        responseButton.frame = CGRectMake(rect.width/2 - responseButton.bounds.width/2, 20 + nextButton.bounds.height/2 - responseButton.bounds.height/2, responseButton.bounds.width, responseButton.bounds.height)
       
        questionLabel.frame = CGRectMake(rect.width/2 - questionLabel.bounds.width/2, 20 + previousButton.bounds.height + 20, questionLabel.bounds.width, questionLabel.bounds.height)
        
        questionView.frame = CGRectMake(20, 20 + nextButton.bounds.height + 20 + questionLabel.bounds.height + 20, rect.width - 20*2, rect.height/18)
        
        responseLabel.frame = CGRectMake(rect.width/2 - responseLabel.bounds.width/2, 20 + nextButton.bounds.height + 20 + questionLabel.bounds.height + 20 + questionView.bounds.height + 20, responseLabel.bounds.width, responseLabel.bounds.height)
        
        responseView.frame = CGRectMake(20, 20 + nextButton.bounds.height + 20 + questionLabel.bounds.height + 20 + questionView.bounds.height + 20 + responseLabel.bounds.height + 20, rect.width - 20*2, rect.height/18)
        
        
        if (device.userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            seenLabel.frame = CGRectMake(20, rect.height - 20 - seenLabel.bounds.height, seenLabel.frame.width, seenLabel.frame.height)
            
            geekSwitch.frame = CGRectMake(rect.width - 20 - geekSwitch.bounds.width, rect.height - 20 - geekSwitch.frame.height, geekSwitch.frame.width, geekSwitch.frame.height)
        }
        else
        {
            seenLabel.frame = CGRectMake(20, 20 + nextButton.bounds.height + 20 + questionLabel.bounds.height + 20 + questionView.bounds.height + 20 + responseLabel.bounds.height + 20 + responseView.frame.height + 20, seenLabel.frame.width, seenLabel.frame.height)
            
            geekSwitch.frame = CGRectMake(rect.width - 20 - geekSwitch.bounds.width, 20 + nextButton.bounds.height + 20 + questionLabel.bounds.height + 20 + questionView.bounds.height + 20 + responseLabel.bounds.height + 20 + responseView.frame.height + 20, geekSwitch.frame.width, geekSwitch.frame.height)

        }
        
    }
    
    func viewWillTransitionToSize(size: CGSize){
        println("viewWill")
        self.drawRect(CGRectMake(0, 0, size.width, size.height))
    }
    
    func nextQuestion(sender: UIButton!){
        currentQuestion = (currentQuestion + 1) % questionTab.size()
        (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
       
        while !(geekSwitch.on || geekSwitch.on == level){
            currentQuestion = (currentQuestion + 1) % questionTab.size()
            (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
        }
        
        affichage()
    }
    
    func previousQuestion(sender: UIButton){
        if (currentQuestion == 0){
            currentQuestion = questionTab.size() - 1
        }else{
            currentQuestion = (currentQuestion - 1) % questionTab.size()
        }
       
        (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
        while !(geekSwitch.on || geekSwitch.on == level){
            if (currentQuestion == 0){
                currentQuestion = questionTab.size() - 1
            }else{
                currentQuestion = (currentQuestion - 1) % questionTab.size()
            }

            (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
        }
        
        affichage()
    }
    
    func getResponse(sender: UIButton){
        if (!isSeen){
            isSeen = true
            questionTab.setSeen(currentQuestion)
            ++seen
        }
        
        affichage()
    }
    
    func changeMode(sender: UIButton){
        if (!geekSwitch.on && level){
            if (currentQuestion == 0){
                currentQuestion = questionTab.size() - 1
            }else{
                currentQuestion = (currentQuestion - 1) % questionTab.size()
            }
            
            (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
            while !(geekSwitch.on || geekSwitch.on == level){
                if (currentQuestion == 0){
                    currentQuestion = questionTab.size() - 1
                }else{
                    currentQuestion = (currentQuestion - 1) % questionTab.size()
                }
                
                (level, question, response, isSeen) = questionTab.getQuizz(currentQuestion)
            }
        }
        
        affichage()
    }
    
    func affichage(){
        questionView.text = question
        questionView.textAlignment = NSTextAlignment.Center
        
        if (level){
            questionView.textColor = UIColor.redColor()
            
            if (isSeen){
                responseView.text = response
                responseView.textAlignment = NSTextAlignment.Center
                responseView.textColor = UIColor.redColor()
            }else{
                responseView.text = ""
            }
        }else{
            questionView.textColor = UIColor.blueColor()
            
            if (isSeen){
                responseView.text = response
                responseView.textAlignment = NSTextAlignment.Center
                responseView.textColor = UIColor.blueColor()
            }else{
                responseView.text = ""
            }
        }
        
        seenLabel.text = "Réponses vues: " + seen.description
        seenLabel.sizeToFit()
    }
}













