//
//  QuestionGroupCaretaker.swift
//  Pruebas
//
//  Created by Julio Banda on 8/13/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

public final class QuestionGroupCaretaker {
    
    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    public init(){
        loadQuestionGroups()
    }
    
    func loadQuestionGroups() {
        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: fileName) {
            self.questionGroups = questionGroups
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            
            self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
            try! save()
        }
    }
    
    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
    
}
