//
//  RoomType.swift
//  Pruebas
//
//  Created by Julio Banda on 29/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

struct RoomType: Equatable {
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
    
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static func ==(lhs: RoomType, rhs: RoomType) -> Bool {
        return lhs.id == rhs.id
    }
    
}