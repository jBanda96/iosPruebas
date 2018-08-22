//
//  Emoji.swift
//  Pruebas
//
//  Created by Julio Banda on 16/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

struct Emoji: CustomStringConvertible {
    
    /** A string that holds the actual emoji symbol */
    let symbol: String
    
    /** A string representing the emoji name in plain text */
    let name: String?
    
    /** A string describing the emoji in plain text */
    let describing: String
    
    /** A string listing the emoji's usage or synonym in plain text */
    let usage: String
    
    /** A string used by grouping */
    let group: Group
    
    var description: String {
        return "Emoji(Symbol: \(symbol), Name: \(name ?? "nil"), Description: \(describing), Usage: \(usage), Grouping: \(group))"
    }
    
}

enum Group {
    case people
    case animalsAndNature
    case foodAndDrink
    case activity
    case symbols
}
