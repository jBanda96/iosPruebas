//
//  Friend+CoreDataProperties.swift
//  
//
//  Created by Julio Banda on 2/18/19.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var name: String?

}
