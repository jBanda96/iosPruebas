//
//  UNService.swift
//  Pruebas
//
//  Created by Julio Banda on 11/13/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation
import UserNotifications

class UNService : NSObject {
    
    static let shared = UNService()
    private override init() {}
    
    let unCenter    =   UNUserNotificationCenter.current()
    let sound       =   UNNotificationSound(named: "R2D2.mp3")
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert,
                                               .badge,
                                               .sound,
                                               .carPlay]
        
        unCenter.requestAuthorization(options: options) { (granted, error) in
            
            guard granted else {
                print("USER DENIED ACCESS")
                return
            }
            
            self.configure()
            
        }
        
    }
    
    private func configure(){
        unCenter.delegate = self
        setUpActionAndCategories()
    }
    
    func setUpActionAndCategories() {
        let timerAction         =   UNNotificationAction(identifier: NotificationActionID.timer.rawValue,
                                               title: "Run timer logic",
                                               options: [.authenticationRequired])
        
        let dateAction          =   UNNotificationAction(identifier: NotificationActionID.date.rawValue,
                                              title: "Run date logic",
                                              options: [.destructive])
        
        let locationAction      =   UNNotificationAction(identifier: NotificationActionID.location.rawValue,
                                                  title: "Run location logic",
                                                  options: [.foreground])
        
        let timerCategory       =   UNNotificationCategory(identifier: NotificationCategory.timer.rawValue,
                                                   actions: [timerAction],
                                                   intentIdentifiers: [],
                                                   options: [])
        
        let dateCategory        =   UNNotificationCategory(identifier: NotificationCategory.date.rawValue,
                                                  actions: [dateAction],
                                                  intentIdentifiers: [],
                                                  options: [])
        
        let locationCategory    =    UNNotificationCategory(identifier: NotificationCategory.location.rawValue,
                                                      actions: [locationAction],
                                                      intentIdentifiers: [],
                                                      options: [])
        
        unCenter.setNotificationCategories([timerCategory, dateCategory, locationCategory])
        
    }
    
    func getAttachment(id: NotificationAttachmentID) -> UNNotificationAttachment? {
        let imageName: String
        
        switch id {
            
        case    .timer: imageName = "TimeAlert"
            
        case     .date: imageName = "DateAlert"
            
        case .location: imageName = "LocationAlert"
            
        }
        
        guard let url = Bundle.main.url(forResource: imageName, withExtension: ".gif") else { return nil }
        
        do {
            
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
            
        } catch {
            return nil
        }
        
    }
    
    func timerRequest(with interval: TimeInterval){
        let content                     =   UNMutableNotificationContent()
            content.title               =   "Timer has finish"
            content.body                =   "Your timer is all done"
            content.sound               =   sound
            content.badge               =   1
            content.categoryIdentifier  =   NotificationCategory.timer.rawValue
        
        if let attachment = getAttachment(id: .timer) {
            content.attachments = [attachment]
        }
        
        let trigger         =   UNTimeIntervalNotificationTrigger(timeInterval: interval,
                                                                  repeats: false)
        
        let request         =   UNNotificationRequest(identifier: "userNotification",
                                                      content: content,
                                                      trigger: trigger)
        
        unCenter.add(request) { (error) in
            print("Timer request did tap")
            content.badge = nil
        }
        
    }
    
    func dateRequest(with components: DateComponents){
let content                         =   UNMutableNotificationContent()
        content.title               =   "Date Trigger"
        content.body                =   "It is now the future!!!"
        content.sound               =   sound
        content.badge               =   1
        content.categoryIdentifier  =   NotificationCategory.date.rawValue
        
        if let attachment = getAttachment(id: .date) {
            content.attachments = [attachment]
        }
        
        let trigger     =   UNCalendarNotificationTrigger(dateMatching: components,
                                                          repeats: true)
        
        let request     =   UNNotificationRequest(identifier: "userNotification",
                                                  content: content,
                                                  trigger: trigger)
        
        unCenter.add(request,
                     withCompletionHandler: nil)
        
    }
    
    func locationRequest(){
        let content                 =   UNMutableNotificationContent()
        content.title               =   "You have returned"
        content.body                =   "Welcome Back!!!"
        content.sound               =   sound
        content.categoryIdentifier  =   NotificationCategory.location.rawValue
        
        if let attachment = getAttachment(id: .location) {
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.location",
                                            content: content,
                                            trigger: nil)
        
        unCenter.add(request)
        
    }
}


extension UNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UserNotification did receive response")
        
        if let action = NotificationActionID.init(rawValue: response.actionIdentifier) {
            NotificationCenter.default.post(name: NSNotification.Name("internalNotification.handleAction"), object: action)
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UserNotification will present")
        
        let options: UNNotificationPresentationOptions = [.alert,
                                                          .badge,
                                                          .sound]
        completionHandler(options)
    }
}
