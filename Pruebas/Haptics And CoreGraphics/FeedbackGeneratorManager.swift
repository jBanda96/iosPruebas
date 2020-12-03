//
//  FeedbackGeneratorManager.swift
//  Pruebas
//
//  Created by Julio Banda on 25/11/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation

class FeedbackGeneratorManager {
    
    enum FeedbackType {
        case impact, selection, notification
    }
    
    static let factory = FeedbackGeneratorManager()
    
    private init() { }
    
    internal func createFeedback(type: FeedbackType) -> UIFeedbackGenerator {
        let feedback: UIFeedbackGenerator
        
        switch type {
        case .impact:
            feedback = UIImpactFeedbackGenerator()
        case .selection:
            feedback = UISelectionFeedbackGenerator()
        case .notification:
            feedback = UINotificationFeedbackGenerator()
        }
        
        return feedback
    }
    
}
