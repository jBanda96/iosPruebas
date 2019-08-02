//
//  Friend+CoreDataProperties.swift
//  
//
//  Created by Julio Banda on 5/7/19.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var pets: NSSet?

}

// MARK: Generated accessors for pets
extension Friend {

    @objc(addPetsObject:)
    @NSManaged public func addToPets(_ value: Pets)

    @objc(removePetsObject:)
    @NSManaged public func removeFromPets(_ value: Pets)

    @objc(addPets:)
    @NSManaged public func addToPets(_ values: NSSet)

    @objc(removePets:)
    @NSManaged public func removeFromPets(_ values: NSSet)

}
