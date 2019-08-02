//
//  CoreLocationViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 4/28/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CoreLocationViewController: NoNavigationBarViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        
        return manager
    }()
    
    let interestedLocations = [
        Location(name: "Parque espejo de los lirios",       latitude: 19.655247,    longuitude: -99.221309,     image: #imageLiteral(resourceName: "lago")),
        Location(name: "Luna Parc",                         latitude: 19.657673,    longuitude: -99.211041,     image: #imageLiteral(resourceName: "luna")),
        Location(name: "Museo Nacional del Virreinato",     latitude: 19.713085,    longuitude: -99.222001,     image: #imageLiteral(resourceName: "virreinato")),
        Location(name: "Castillo de Chapultepec",           latitude: 19.420527,    longuitude: -99.181549,     image: #imageLiteral(resourceName: "chapu")),
        Location(name: "Palacio de Bellas Artes",           latitude: 19.435078,    longuitude: -99.141535,     image: #imageLiteral(resourceName: "artes"))
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
            
            print("Placemarks count: \(String(describing: placemark!.first!.location))")
        }
        
        map.showsUserLocation = true
        map.addAnnotations(interestedLocations)
    }
    
    // MARK: - IBActions
    @IBAction func changeMapType (_ button: UISegmentedControl) {
        if button.selectedSegmentIndex == 0 {
            map.mapType = .satellite
        } else {
            map.mapType = .standard
        }
        
        loadDirections()
    }
    
}


extension CoreLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "i") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "i")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.markerTintColor = .green
        annotationView?.glyphText = "👀"
        
        annotationView?.detailCalloutAccessoryView = UIImageView(image: (annotation as! Location).image)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polygonRenderer = MKPolylineRenderer(overlay: overlay)
        polygonRenderer.strokeColor = .gray
        polygonRenderer.lineCap = .round
        polygonRenderer.lineWidth = 8.0
        
        return polygonRenderer
    }
    
    func loadDirections() {
        
        map.setRegion(MKCoordinateRegion(center: currentLocation!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
        
        let request = MKDirections.Request()
        
        guard let start = currentLocation, let end = interestedLocations.last else { return }
        let startMapItem    =   MKMapItem(placemark: MKPlacemark(coordinate: start.coordinate))
        let endMapImten     =   MKMapItem(placemark: MKPlacemark(coordinate: end.coordinate))
        
        request.source      =   startMapItem
        request.destination =   endMapImten
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate {(response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "No existe ningún error")
                return
            }
            
            if let route = response?.routes.first {
                let formatter = MKDistanceFormatter()
                formatter.unitStyle = .full
                self.map.add(route.polyline)
                for step in route.steps {
                    let distance = formatter.string(fromDistance: step.distance)
                    print(distance)
                }
            }
            
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
            //            let distanceInMeters = currentLocation?.distance(from: latest)
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
        print("You entered to \(region.identifier)")
    }
    
}

