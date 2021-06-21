//
//  Question.swift
//  QFproject
//
//  Created by Dicky Buwono on 15/06/21.
//

import Foundation


class Question {
    let questionImage: String
    let question: String
    let optionA: String
    let optionB: String
    
    init(image: String, questionText: String, choiceA: String, choiceB: String){
        questionImage = image
        question = questionText
        optionA = choiceA
        optionB = choiceB
    }
}
