//
//  PersistenceManager.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift

class PersistenceManager: PersistenceProtocol {
    
    private let realm = try! Realm()
    var instance: Realm {
        return realm
    }
    
    func saveObject<T>(_ object: T) where T : Object {
        try! self.realm.write {
            instance.deleteAll()
            instance.add(object)
        }
    }
    
    func fetchObjects(_ type: Object.Type) -> Results<Object>? {
        let results = realm.objects(type)
        return results
    }
    
    
    static func configureMigration() {
        let newSchema: UInt64 = 26
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: newSchema,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < newSchema) {
                    migrate(with: migration)
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
    
    func isDatabaseEmpty<T: Object>(_ type: T.Type) -> Bool {
        let objects = instance.objects(type)
        return objects.isEmpty
    }
    
    // MARK: - Migrations
    static func migrate(with migration: Migration) {}
}
