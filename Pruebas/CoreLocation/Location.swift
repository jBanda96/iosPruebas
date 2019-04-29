//
//  Location.swift
//  Pruebas
//
//  Created by Julio Banda on 4/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    let name: String
    let location: CLLocation
    
    init(name: String, latitude: Double, longuitude: Double) {
        self.name = name
        self.location = CLLocation(latitude: latitude, longitude: longuitude)
    }
    
}
