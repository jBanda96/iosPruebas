//
//  QuestionGroup.swift
//  Pruebas
//
//  Created by Julio Banda on 7/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    
    public class Score: Codable {
        public var correctCount:    Int = 0
        public var incorrectCount:  Int = 0
        public init() { }
    }
    
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    public init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
    
}
