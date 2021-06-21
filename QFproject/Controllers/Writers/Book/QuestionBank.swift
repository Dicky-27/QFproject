//
//  QuestionBank.swift
//  QFproject
//
//  Created by Dicky Buwono on 15/06/21.
//

import Foundation

class QuestionBank{
    var list = [Question]()
    
    init() {
        
        list.append(Question(image: "Question Intelligence", questionText: "Your character wants to learn how to cook and finds this recipe book! What would your character do?", choiceA: "Read and follow it thoroughly", choiceB: "Disregard it and \nstart cooking anyway"))
        
        list.append(Question(image: "Question Intelligence", questionText: "When in school, your character is more likely to:", choiceA: "Take notes", choiceB: "Not paying attention"))
        
        list.append(Question(image: "Question Intelligence", questionText: "When trying new things, your character is more likely to:", choiceA: "Do the traditional way", choiceB: " Explore new ideas"))
      
    }
}



