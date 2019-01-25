//
//  ChecklistItem.swift
//  Pruebas
//
//  Created by Julio Banda on 1/1/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    
    enum Priority: Int, CaseIterable {
        case high, medium, low, later
    }
    
    var text:               String
    var checked:            Bool
    var priority:           Priority
    
    var isChecked: Bool {
        get {
            return checked
        }
        
        set {
            checked = newValue
        }
    }
    
    override var description: String {
        return "ChecklistItem(text: \(text), checked: \(checked), priority: \(priority))"
    }
    
    init(text: String, priority: Priority, checked: Bool = false) {
        self.text       =   text
        self.checked    =   checked
        self.priority   = priority
    }
    
    func toggle() {
        self.isChecked = !isChecked
    }
    
}
