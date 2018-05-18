//
//  AbstractManager.swift
//  Pruebas
//
//  Created by Julio Banda on 06/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import CoreData

class AbstractManager: NSObject {

    // The managedObjectContext for core data
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
        
    }()
    
}
