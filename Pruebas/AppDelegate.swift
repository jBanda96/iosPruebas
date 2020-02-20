//
//  AppDelegate.swift
//  Modified by Julio Banda
//
//  Created by Julio Banda on 28/04/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase
import CoreNFC

func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var session: NFCNDEFReaderSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        RNService.shared.requestAuthorization(for: application)
        FirebaseApp.configure()
        
        InstanceID.instanceID().instanceID { (token, _) in
            print("Token for primary app: \(token?.token)")
        }
        
        print("Operation: \(String(describing: Calculator.sharedCalculator.performOperation(1, .plus, 3)))")                // 4
        print("Operation: \(String(describing: Calculator.sharedCalculator.performOperation(1, .minus, 3)))")               // -2
        print("Operation: \(String(describing: Calculator.sharedCalculator.performOperation(1, .multiplication, 3)))")      // 3
        print("Operation: \(String(describing: Calculator.sharedCalculator.performOperation(1, .division, 3)))")            // 1/3
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Messaging.messaging().apnsToken = deviceToken
        let token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
        print("Token APNs: \(token)")
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "List")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: NFCNDEFReaderSessionDelegate {
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("NFC Messages: \(messages)")
    }
}
