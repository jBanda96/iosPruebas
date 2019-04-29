//
//  CoreLocationViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import CoreLocation

class CoreLocationViewController: UIViewController {
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        
        return manager
    }()
    
    let interestedLocations = [
        Location(name: "Parque espejo de los lirios",       latitude: 19.655247,    longuitude: -99.221309),
        Location(name: "Luna Parc",                         latitude: 19.657673,    longuitude: -99.211041),
        Location(name: "Museo Nacional del Virreinato",     latitude: 19.713085,    longuitude: -99.222001),
        Location(name: "Castillo de Chapultepec",           latitude: 19.420527,    longuitude: -99.181549),
        Location(name: "Palacio de Bellas Artes",           latitude: 19.435078,    longuitude: -99.141535)
    ]
    
    var currentLocation: CLLocation?
    
    // MARK: - Lyfecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForLocationStatus()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("Mexico") { (placemark, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            print("Placemarks count: \(placemark!.first!.location)")
            
        }
    }
    
}

extension CoreLocationViewController: CLLocationManagerDelegate {
    func checkForLocationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            activateLocationServices()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func activateLocationServices(){
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            for place in interestedLocations {
                let region = CLCircularRegion(center: place.location.coordinate, radius: 1000, identifier: place.name)
                region.notifyOnEntry = true
                locationManager.startMonitoring(for: region)
            }
        }
        
        locationManager.startUpdatingLocation()
    }
    
    // MARK: Conform to LocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            activateLocationServices()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.first
        } else {
            guard let latest = locations.first else { return }
            let distanceInMeters = currentLocation?.distance(from: latest)
//            print("Distance in meters: \(String(describing: distanceInMeters))")
            currentLocation = latest
        }
        
//        for place in interestedLocations {
//            let distanceInMeters = currentLocation?.distance(from: place.location)
//            let distance = Measurement(value: distanceInMeters ?? 0, unit: UnitLength.meters)
//
//            print("\(place.name) \(distance.converted(to: UnitLength.kilometers))")
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }

}
