//
//  NotificationsViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 11/13/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UNService.shared.authorize()
        CLService.shared.authorize()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                                   name: NSNotification.Name("internalNotification.enterRegion"),
                                                 object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name: NSNotification.Name("internalNotification.handleAction"),
                                               object: nil)
        
    }
    
    @IBAction func onTimerTap() {
        print("Timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5.0)
        }
        
    }
    
    @IBAction func onDateTap() {
        print("Date")
        
        var components = DateComponents()
        components.second = 58
        AlertService.actionSheet(in: self, title: "Some future time") {
            UNService.shared.dateRequest(with: components)
        }
    }
    
    @IBAction func onLocationTap() {
        print("Location")
        AlertService.actionSheet(in: self, title: "When I return") {
            CLService.shared.updateLocation()
        }
    }

    @objc
    func didEnterRegion(){
        UNService.shared.locationRequest()
    }
    
    @objc
    func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionID else { return }
        
        switch action {
        case    .timer:
            
            let animationsViewController    =   UIStoryboard.init(name: "CustomView", bundle: nil).instantiateViewController(withIdentifier: "torchViewController")
            
            self.navigationController?.pushViewController(animationsViewController,
                                                          animated: true)
            
        case     .date:     print("Date logic running")
        case .location:     print("Location logic running")
            
            
            
        }
        
    }
    
}
