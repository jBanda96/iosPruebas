//
//  LocationViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 03/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var myLocationAnnotation: MKAnnotation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        addTestAnnotations()
    }
    
    @IBAction func didClickOnLocateMe(_ sender: UIBarButtonItem) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            let status = CLLocationManager.authorizationStatus()
            
            switch status {
            case .denied, .restricted :
                self.showAlertWithMessage("Your app is not authorized to use access user's location. Please check device status")
                
            case .authorizedAlways, .authorizedWhenInUse:
                startUpdatingLocation()
                
            case .notDetermined:
                self.showPermissionAlert()
            }
            
        } else {
            showAlertWithMessage("Location services is disable. Please enable it from settings")
        }
        
    }
    
    func showPermissionAlert() {
        self.locationManager.requestWhenInUseAuthorization()
        self.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func addTestAnnotations() {
        
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 60.1690368, longitude: 24.9370282)
        annotation1.title = "Stockman"
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 60.1716389, longitude: 29.9405934)
        annotation2.title = "Aleksis Kiven"
        
        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 60.17152, longitude: 24.9466044)
        annotation3.title = "Aleksis Kiven"
        annotation3.subtitle = "This is a test"
        
        self.mapView.addAnnotations([annotation1, annotation2, annotation3])
        self.mapView.showAnnotations([annotation1, annotation2, annotation3], animated: true)
        
    }
    
    func showAlertWithMessage(_ message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first{
            
            if let annotation = self.myLocationAnnotation {
                self.mapView.removeAnnotation(annotation)
            }
            
            let customAnnotation = CustomAnnotation(location: location.coordinate)
            customAnnotation.title = "You're here"
            self.myLocationAnnotation = customAnnotation
            self.mapView.addAnnotation(customAnnotation)
            
        }
    }
    
}

extension LocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if annotation.isKind(of: CustomAnnotation.self) {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomView")
            annotationView.image = #imageLiteral(resourceName: "car.png")
            return annotationView
        } else {
            
            var pinView: MKPinAnnotationView
            
            if let pv = mapView.dequeueReusableAnnotationView(withIdentifier: "PinView") as? MKPinAnnotationView {
                pinView = pv
                pinView.annotation = annotation
            } else {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinView")
                pinView.pinTintColor = .red
                pinView.animatesDrop = true
                pinView.canShowCallout = true
            }
            
            return pinView
            
        }
        
    }
    
}



class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String? = ""
    var color: UIColor
    
    override init() {
        coordinate = CLLocationCoordinate2D()
        color = .black
    }
    
    init(location: CLLocationCoordinate2D) {
        self.coordinate = location
        self.color = .black
    }
    
    init(location: CLLocationCoordinate2D, color: UIColor) {
        self.coordinate = location
        self.color = color
    }
    
}























