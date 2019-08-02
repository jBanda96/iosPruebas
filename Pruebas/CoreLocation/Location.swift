//
//  Location.swift
//  Pruebas
//
//  Created by Julio Banda on 4/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Location: NSObject {
    
    let name: String
    let location: CLLocation
    let image: UIImage
    
    init(name: String, latitude: Double, longuitude: Double, image: UIImage) {
        self.name = name
        self.location = CLLocation(latitude: latitude, longitude: longuitude)
        self.image = image
    }
    
}


extension Location: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    var title: String? {
        return name
    }
    
}
