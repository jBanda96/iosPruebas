//
//  ArtWork.swift
//  Pruebas
//
//  Created by Julio Banda on 6/16/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class ArtWork: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(json: [Any]) {
        self.title          =       json[16] as? String ?? "No title"
        self.locationName   =       json[12] as! String
        self.discipline     =       json[15] as! String
        
        if let latitude = Double(json[18] as! String),
            let longitude = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        
    }
    
    var imageName: String? {
        if discipline == "Sculpture" {
            return "Statue"
        }
        
        return "Flag"
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary   =   [CNPostalAddressStreetKey : subtitle!]
        let placeMark           =   MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem             =   MKMapItem(placemark: placeMark)
        mapItem.name = title
        
        return mapItem
    }
    
    var markerTintColor: UIColor {
        switch discipline {
        case "Monument":
            return .red
        case "Mural":
            return .cyan
        case "Plaque":
            return .blue
        case "Sculpture":
            return .purple
        default:
            return .green
        }
    }
    
}
