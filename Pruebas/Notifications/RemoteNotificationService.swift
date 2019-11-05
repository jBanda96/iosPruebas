//
//  RemoteNotificationService.swift
//  Pruebas
//
//  Created by Julio Banda on 9/23/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class RNService: NSObject {
    
    let categoryButtonsId: String = "acceptOrReject"
    let categoryUIId: String = "showMap"
    let categoryMapActions: String = "categoryMapActions"
    enum ActionButtonsId: String { case accept, reject }
    enum ActionUIId: String { case comment }
    
    public static let shared = RNService()
    private let unCenter = UNUserNotificationCenter.current()
    
    private override init() { }
    
    func requestAuthorization(for app: UIApplication) {
        unCenter.requestAuthorization(options: [.sound, .badge, .alert]) { [weak self] (granted, error) in
            guard granted else { return }
            
            DispatchQueue.main.async {
                app.registerForRemoteNotifications()
            }
            
            self?.configure()
        }
    }
    
    func configure() {
        unCenter.delegate = self
        self.registerCustomActions()
    }
    
    private func registerCustomActions() {
        let accept = UNNotificationAction(identifier: ActionButtonsId.accept.rawValue, title: "Accept")
        let reject = UNNotificationAction(identifier: ActionButtonsId.reject.rawValue, title: "Reject")
        let categoryButtons = UNNotificationCategory(identifier: categoryButtonsId, actions: [accept, reject], intentIdentifiers: [])
        
        let comment = UNTextInputNotificationAction(identifier: ActionUIId.comment.rawValue, title: "Comment")
        let showMapCategory = UNNotificationCategory(identifier: categoryUIId, actions: [comment], intentIdentifiers: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([categoryButtons, showMapCategory])
    }
    
    private func show(message: String) -> UIAlertController {
        let actionOk = UIAlertAction(title: "OK", style: .default)
        
        let controller = UIAlertController(title: "Push", message: message, preferredStyle: .alert)
        controller.addAction(actionOk)
        
        return controller
    }
    
}

extension RNService: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let notificationOptions: UNNotificationPresentationOptions = [.sound, .badge, .alert]
        
        completionHandler(notificationOptions)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        defer { completionHandler() }
        
        if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
            let payload = response.notification.request.content
            guard let _ = payload.userInfo["sayHi"] else { return }
            (UIApplication.shared).keyWindow?.rootViewController?.present(show(message: "Holaaaaa"), animated: true)
        }
        
        let identity = response.notification.request.content.categoryIdentifier
        guard identity == categoryButtonsId,
            let action = ActionButtonsId(rawValue: response.actionIdentifier) else { return }
        print("You pressed \(action.rawValue)")
        
    }
}
