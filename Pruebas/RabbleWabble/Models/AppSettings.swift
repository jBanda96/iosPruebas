//
//  AppSettings.swift
//  Pruebas
//
//  Created by Julio Banda on 8/8/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class AppSettings {
    // MARK: Keys
    private struct Keys {
        static let questionStrategy: String = "questionStrategy"
    }
    
    // MARK: Static properties
    static let shared = AppSettings()
    
    // Mark: Instance Properties
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = UserDefaults.standard.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    // MARK: Instance Methods
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
    
    // MARK: Object lifecycle
    private init() { }
}

// MARK: Question Strategy Type
public enum QuestionStrategyType: Int, CaseIterable {
    case random, sequential
    
    // MARK: Instance Methods
    public func title() -> String {
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
        }
    }
    
}
