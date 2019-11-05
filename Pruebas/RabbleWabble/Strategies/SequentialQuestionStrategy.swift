//
//  SequentialQuestionStrategy.swift
//  Pruebas
//
//  Created by Julio Banda on 8/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class SequentialQuestionStrategy: BaseQuestionStrategy {
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
