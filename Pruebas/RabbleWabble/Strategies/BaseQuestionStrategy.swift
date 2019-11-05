//
//  BaseQuestionStrategy.swift
//  Pruebas
//
//  Created by Julio Banda on 8/13/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class BaseQuestionStrategy: QuestionStrategy {
    
    var title: String {
        return questionGroup.title
    }
    
    private var questionGroupCaretaker: QuestionGroupCaretaker
    
    private var questionGroup: QuestionGroup {
        return questionGroupCaretaker.selectedQuestionGroup
    }
    
    private var questionIndex = 0
    private let questions: [Question]
    
    public var correctCount: Int {
        get { return questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }
    public var incorrectCount: Int {
        get { return questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }
    
    public init(questionGroupCaretaker: QuestionGroupCaretaker, questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        
        self.questionGroupCaretaker.selectedQuestionGroup.score = QuestionGroup.Score()
    }
    
    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()
        guard questionIndex + 1 < questionGroup.questions.count else { return false }
        
        questionIndex += 1
        return true
    }
    
    public func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    
    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return "\(questionIndex)/\(questionGroup.questions.count)"
    }
    

}
