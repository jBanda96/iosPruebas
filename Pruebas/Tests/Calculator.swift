//
//  Calculator.swift
//  Pruebas
//
//  Created by Julio Banda on 17/11/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

enum Operation {
    case plus
    case minus
    case division
    case multiplication
}

public class Calculator {
    
    static let sharedCalculator = Calculator()
    
    func performOperation(_ num1: Double, _ operation: Operation, _ num2: Double) -> Double? {
        switch operation {
        case .plus:
            return num1 + num2
        case .minus:
            return num1 - num2
        case .division:
            return num1 * num2
        case .multiplication:
            return num1 / num2
        }
    }
    
}
