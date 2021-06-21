//
//  QuestionBankRubs.swift
//  QFproject
//
//  Created by Dicky Buwono on 17/06/21.
//

import Foundation

class QuestionBankRubick{
    var list2 = [QuestionRubick]()
    
    init() {
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "How do your character react when they first encounter a problem?", choiceA: "Worry", choiceB: "Point out what’s wrong", choiceC: "Think about all the ideas they have", choiceD: "Take action right away", choiceE: "Make a specific plan"))
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "Which of these statements is your character more likely to say?", choiceA: "What if I fail?", choiceB: "That definitely won’t work", choiceC: "Wouldn’t it be great if …?", choiceD: "I’ll never give up!", choiceE: "I’m going to figure out what I can do"))
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "Your character failed a project. Your character thinks the cause it’s because...", choiceA: "They’re just not that talented", choiceB: "Others failed to do the job", choiceC: "They didn’t finish it", choiceD: "They didn’t try hard enough", choiceE: "Something didn’t work out"))
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "During teamworks, your character is more likely to:", choiceA: "Stay silent", choiceB: "Reject ideas", choiceC: "Daydream", choiceD: "Jump to execution", choiceE: "Collaborate and make plans"))
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "What’s stopping your character from taking action?", choiceA: "Fear of failure", choiceB: "They keep complaining about others", choiceC: "They don’t like to get into details", choiceD: "Nothing", choiceE: "They need time to reflect and evaluate"))
        
        list2.append(QuestionRubick(image: "Problem Solving Question", questionText: "What would other people say about your character?", choiceA: "They’re kinda pessimistic", choiceB: "They’re too judgemental", choiceC: "They have so many ideas", choiceD: "They’re very proactive", choiceE: "They’re a strategic thinker"))
        
       
      
    }
}
