//
//  DBManager.swift
//  Pruebas
//
//  Created by Julio Banda on 17/05/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    
    private var database: Realm
    static let sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<Objecto> {
        let results: Results = database.objects(Objecto.self)
        return results
    }

    func addData(object: Object) {
        try! database.write {
            database.add(object, update: true)
            print("Added a new object")
        }
    }
    
    func deleteAllFromDatabase() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: Object) {
        try! database.write {
            database.delete(object)
        }
    }
    
}

class Objecto: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
