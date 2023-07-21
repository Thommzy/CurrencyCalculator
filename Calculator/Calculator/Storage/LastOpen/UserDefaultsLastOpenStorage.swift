//
//  UserDefaultsLastOpenStorage.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/21/23.
//

import Foundation

// Protocol to define the behavior of a storage mechanism for last open timestamp
protocol LastOpenStorage {
    func getLastOpenTimestamp() -> TimeInterval?
    func setLastOpenTimestamp(_ timestamp: TimeInterval)
}

// UserDefaultsLastOpenStorage: Implementation of LastOpenStorage using UserDefaults
class UserDefaultsLastOpenStorage: LastOpenStorage {
    // Key for storing the last open timestamp in UserDefaults
    private let lastOpenKey = "LastOpenTimestamp"
    
    // Retrieve the last open timestamp from UserDefaults
    func getLastOpenTimestamp() -> TimeInterval? {
        return UserDefaults.standard.object(forKey: lastOpenKey) as? TimeInterval
    }
    
    // Set the last open timestamp in UserDefaults
    func setLastOpenTimestamp(_ timestamp: TimeInterval) {
        UserDefaults.standard.set(timestamp, forKey: lastOpenKey)
    }
}

