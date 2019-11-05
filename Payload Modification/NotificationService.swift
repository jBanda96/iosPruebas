//
//  NotificationService.swift
//  Payload Modification
//
//  Created by Julio Banda on 10/6/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest,
                             withContentHandler contentHandler:
        @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        self.bestAttemptContent = (request.content.mutableCopy()
            as? UNMutableNotificationContent)
        
        // Try to decode the encrypted message data.
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = ROT13.shared.decrypt(bestAttemptContent.title)
            bestAttemptContent.body = ROT13.shared.decrypt(bestAttemptContent.body)
            
            if let urlPath = request.content.userInfo["media-url"] as? String,
                let url = URL(string: ROT13.shared.decrypt(urlPath)) {
                let destination = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(url.lastPathComponent)
                
                do {
                    let data = try Data(contentsOf: url)
                    try data.write(to: destination)
                    let attachment = try UNNotificationAttachment.init(identifier: "", url: destination)
                    bestAttemptContent.attachments = [attachment]
                } catch {
                    print(error.localizedDescription)
                }
                
            }
            
            // Always call the completion handler when done.
            contentHandler(bestAttemptContent)
        }
    }
    
    // Return something before time expires.
    override func serviceExtensionTimeWillExpire() {
       if let contentHandler = contentHandler,
          let bestAttemptContent = bestAttemptContent {
             
          // Mark the message as still encrypted.
          bestAttemptContent.subtitle = ROT13.shared.decrypt(bestAttemptContent.title)
          bestAttemptContent.body = ROT13.shared.decrypt(bestAttemptContent.body)
          contentHandler(bestAttemptContent)
       }
    }

}
