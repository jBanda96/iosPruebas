//
//  RandomQuestionStrategy.swift
//  Pruebas
//
//  Created by Julio Banda on 8/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

class RandomQuestionStrategy: BaseQuestionStrategy {
    public convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
