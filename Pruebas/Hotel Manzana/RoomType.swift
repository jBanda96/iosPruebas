//
//  RoomType.swift
//  Pruebas
//
//  Created by Julio Banda on 29/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

struct RoomType: Equatable {
    
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
}
