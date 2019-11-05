//
//  QuestionStrategy.swift
//  Pruebas
//
//  Created by Julio Banda on 8/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

public protocol QuestionStrategy: class {
    var title: String { get }
    
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    
    func currentQuestion() -> Question
    
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    
    func questionIndexTitle() -> String
}
