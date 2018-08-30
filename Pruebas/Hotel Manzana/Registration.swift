//
//  Registration.swift
//  Pruebas
//
//  Created by Julio Banda on 29/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildrens: Int
    
    var roomType: RoomType
    var wifi: Bool
}
