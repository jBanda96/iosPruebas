//
//  GreetingViewModel.swift
//  Pruebas
//
//  Created by Julio Banda on 4/4/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

struct GreetingViewModel {
    
    var person: Person3

    var name: String {
        get {
            return person.firstName
        }
        set {
            person.firstName = newValue
        }
    }
    
    var last: String {
        return person.lastName
    }
    
    func greet() -> String {
        return "Hello \(name) \(last)"
    }
    
}
