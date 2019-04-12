//
//  Player.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class Player: NSObject {
    
    let identifier: String
    var name: String
    
    init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
    }
}
