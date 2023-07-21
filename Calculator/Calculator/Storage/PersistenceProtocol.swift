//
//  PersistenceProtocol.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift

protocol PersistenceProtocol {
    var instance: Realm { get }
    func saveObject<T>(_ object: T) where T: Object
    func fetchObjects(_ type: Object.Type) -> Results<Object>?
    func isDatabaseEmpty<T: Object>(_ type: T.Type) -> Bool
    func clearDatabase()
}
