//
//  Question.swift
//  Pruebas
//
//  Created by Julio Banda on 7/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

public class Question: Codable {
    public let answer: String
    public let hint: String?
    public let prompt: String
    
    public init(answer: String, hint: String?, prompt: String){
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
    
}
