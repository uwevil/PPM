//
//  ViewController.swift
//  Quizz_Swift
//
//  Created by Cao Sang DOAN on 26/09/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var question: UITextView!
    
    @IBOutlet weak var response: UITextView!
    
    @IBOutlet weak var switchMode: UISwitch!
    
    @IBOutlet weak var switchLabel: UILabel!
    
    @IBOutlet weak var seenLabel: UILabel!
    
    let questionTab = QuestionsReponses()
    
    var (currentLevel, currentQuestion, currentResponse, seen) = (false, "", "", false)
    
    var currentIndex = 0
    
    var responseSeen = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        switchMode.setOn(false, animated: false)   
        (currentLevel, currentQuestion, currentResponse, seen) = questionTab.getQuizz(currentIndex)

        affichage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func nextQuestion(sender: UIButton) {
        
        while true
        {
            currentIndex++
            currentIndex = currentIndex % questionTab.size()
            
            (currentLevel, currentQuestion, currentResponse, seen) = questionTab.getQuizz(currentIndex)
            
            if currentLevel == switchMode.on || switchMode.on
            {
                break;
            }
        }
       
        affichage()
    }

    @IBAction func backQuestion(sender: UIButton) {
        
        while true
        {
            if currentIndex == 0
            {
                currentIndex = questionTab.size()
            }
            
            currentIndex--
            currentIndex = currentIndex % questionTab.size()

            (currentLevel, currentQuestion, currentResponse, seen) = questionTab.getQuizz(currentIndex)
            
            if (currentLevel == switchMode.on || switchMode.on)
            {
                break;
            }
        }
        
        affichage()
    }
    
    @IBAction func getResponse(sender: UIButton) {
        
        if response.text != currentResponse
        {
            responseSeen++
            seenLabel.text = String(format: "Réponses vues: %d", responseSeen)
        }
        
        response.text = currentResponse
        response.textAlignment = NSTextAlignment.Center
        
        if (currentLevel)
        {
            response.textColor = UIColor.redColor()
        }
        else
        {
            response.textColor = UIColor.blueColor()
        }
        
        questionTab.setSeen(currentIndex)
    }
    
    @IBAction func changeMode(sender: UISwitch) {
        
       if !switchMode.on
        {
            switchLabel.text = "Facile"
            if (currentLevel)
            {
                while true
                {
                    if currentIndex == 0
                    {
                        currentIndex = questionTab.size()
                    }
                    
                    currentIndex--
                    currentIndex = currentIndex % questionTab.size()
                    
                    (currentLevel, currentQuestion, currentResponse, seen) = questionTab.getQuizz(currentIndex)
                    
                    if currentLevel == switchMode.on
                    {
                        break;
                    }
                }
            }
        }
        else
       {
            switchLabel.text = "Difficile" 
        }
        
        affichage()
    }
    
    func affichage()
    {
        question.text = currentQuestion
        question.textAlignment = NSTextAlignment.Center
        response.text = ""

        if (currentLevel)
        {
            question.textColor = UIColor.redColor()
            
            if (seen)
            {
                response.text = currentResponse
                response.textAlignment = NSTextAlignment.Center
                response.textColor = UIColor.redColor()
            }
        }
        else
        {
            question.textColor = UIColor.blueColor()
            
            if (seen)
            {
                response.text = currentResponse
                response.textAlignment = NSTextAlignment.Center
                response.textColor = UIColor.blueColor()
            }
        }
        
       
    }
}

