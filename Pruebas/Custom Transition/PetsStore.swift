//
//  PetsStore.swift
//  Pruebas
//
//  Created by Julio Banda on 4/19/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

struct PetsStore {
    
    private init() {}
    
    static var pets: [Pet] {
        return [Pet(name: "Happy", description: "idk", image: #imageLiteral(resourceName: "face9")),
                Pet(name: "Sad", description: "idk", image: #imageLiteral(resourceName: "face15")),
                Pet(name: "Angry", description: "idk", image: #imageLiteral(resourceName: "face2")),
                Pet(name: "Shy", description: "idk", image: #imageLiteral(resourceName: "face0"))
        ]
    }
}
