//
//  HonoluluViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 6/16/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import MapKit

class HonoluluViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var artworks: [ArtWork] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location)
        
        mapView.showsUserLocation = true
        
        loadInitialData()
        mapView.addAnnotations(artworks)
        
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 1_000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String : Any],
            let works = dictionary["data"] as? [[Any]]
        else { return }
        
        let validWorks = works.compactMap{ ArtWork(json: $0) }
        artworks.append(contentsOf: validWorks)
        
    }

}

extension HonoluluViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ArtWork else { return nil }
        
        let identifier: String       =      "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view                    = dequeuedView
        } else {
            
            let mapButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
            mapButton.setBackgroundImage(UIImage(named: "Maps-icon")!, for: UIControlState())
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout                 =           true
            view.rightCalloutAccessoryView      =           mapButton
            view.markerTintColor                =           annotation.markerTintColor
            //view.glyphText                      =           String(annotation.discipline.first!)
            
            if let image = annotation.imageName {
                view.glyphImage = UIImage(named: image)
            } else {
                view.glyphImage = nil
            }
            
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location        =   view.annotation as! ArtWork
        let launchOption    =   [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOption)
    }
}
