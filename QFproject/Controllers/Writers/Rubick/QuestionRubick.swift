//
//  Question.swift
//  QFproject
//
//  Created by Dicky Buwono on 17/06/21.
//

import Foundation

class QuestionRubick {
    let questionImage: String
    let question: String
    let optionA: String
    let optionB: String
    let optionC: String
    let optionD: String
    let optionE: String
    
    init(image: String, questionText: String, choiceA: String, choiceB: String, choiceC: String, choiceD: String, choiceE: String){
        questionImage = image
        question = questionText
        optionA = choiceA
        optionB = choiceB
        optionC = choiceC
        optionD = choiceD
        optionE = choiceE
    }
}
