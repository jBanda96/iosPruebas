//
//  Pets+CoreDataProperties.swift
//  
//
//  Created by Julio Banda on 5/7/19.
//
//

import Foundation
import CoreData


extension Pets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pets> {
        return NSFetchRequest<Pets>(entityName: "Pets")
    }

    @NSManaged public var name: String?
    @NSManaged public var kind: NSData?
    @NSManaged public var picture: String?
    @NSManaged public var dob: NSDate?
    @NSManaged public var owner: Friend?

}
