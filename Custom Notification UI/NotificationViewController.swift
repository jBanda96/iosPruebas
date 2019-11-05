//
//  NotificationViewController.swift
//  Custom Notification UI
//
//  Created by Julio Banda on 03/11/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import MapKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    
    func didReceive(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo
        guard let latitude = userInfo["latitude"] as? CLLocationDistance,
            let longitude = userInfo["longitude"] as? CLLocationDistance,
            let radius = userInfo["radius"] as? CLLocationDistance else { return }
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        
        var images = [UIImage]()
        notification.request.content.attachments.forEach { attachment in
            if attachment.url.startAccessingSecurityScopedResource() {
                if let data = try? Data.init(contentsOf: attachment.url),
                    let image = UIImage(data: data) {
                    images.append(image)
                }
                attachment.url.stopAccessingSecurityScopedResource()
            }
        }
        
        self.mapView.setRegion(region, animated: false)
        self.imageView.image = images.first
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if let response = response as? UNTextInputNotificationResponse {
            let _ = response.userText
            completion(.dismiss)
        }
    }

}
