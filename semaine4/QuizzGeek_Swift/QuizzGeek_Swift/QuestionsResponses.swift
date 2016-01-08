//
//  QuestionsResponses.swift
//  QuizzGeek_Swift
//
//  Created by Cao Sang DOAN on 07/10/15.
//  Copyright (c) 2015 Cao Sang DOAN. All rights reserved.
//

import UIKit

class QuestionsReponses {
    
    private var tabQuizz:[(level: Bool, question : String, response : String, seen : Bool)] = []
    
    init()
    {
        let tuple = (level : false, question : "questionNormal1", response : "responseNormal1", seen: false)
        tabQuizz += [tuple]
        
        tabQuizz += [(level : true, question : "questionHard1", response : "responseHard1", seen: false)]
        tabQuizz += [(level : false, question : "questionNormal2", response : "responseNormal2", seen: false)]
        tabQuizz += [(level : true, question : "questionHard2", response : "responseHard2", seen: false)]
        tabQuizz += [(level : false, question : "questionNormal3", response : "responseNormal3",seen: false)]
        tabQuizz += [(level : true, question : "questionHard3", response : "responseHard3", seen: false)]
        tabQuizz += [(level : false, question : "questionNormal4", response : "responseNormal4", seen: false)]
        tabQuizz += [(level : true, question : "questionHard4", response : "responseHard4", seen: false)]
    }
    
    func addQuizz(l: Bool, q : String, r : String, s: Bool)
    {
        tabQuizz += [(level : l, question : q, response : r, seen: s)]
    }
    
    func getQuizz(index : Int) -> (Bool, String, String, Bool)
    {
        return tabQuizz[index]
    }
    
    func setSeen(index: Int)
    {
        tabQuizz[index].seen = true
    }
    
    func size() -> Int
    {
        return tabQuizz.count
    }
    
}