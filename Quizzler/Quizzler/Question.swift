//
//  Question.swift
//  Quizzler
//
//  Created by Megan Brown on 1/2/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    let questionText: String
    let answer: Bool
    
    // initial values that occur when the class is initialized
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
}

