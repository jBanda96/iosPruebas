//
//  TaskListManager.swift
//  Pruebas
//
//  Created by Julio Banda on 06/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit
import CoreData

extension TaskList {
    
    public static func newEntityName(name: String, context: NSManagedObjectContext) -> TaskList {
        let list = NSEntityDescription.insertNewObject(forEntityName: "TaskList", into: context) as! TaskList
        list.name = name
        return list
    }
    
}

class TaskListManager: AbstractManager {
    
    func addNewList(name: String) {
        
        let list = TaskList.newEntityName(name: name, context: self.managedObjectContext)
        list.createdAt = Date()
        
        do {
            
            try self.managedObjectContext.save()
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func fetchLists(predicate: NSPredicate? = nil) -> [TaskList] {
        
        let fetchRequest = TaskList.fetchRequest() as? NSFetchRequest
        fetchRequest?.predicate = predicate
        
        do {
            let lists = try self.managedObjectContext.fetch(fetchRequest!)
            return lists
        } catch {
            print(error.localizedDescription)
        }
        
        return []
        
    }
    
}
