//
//  AppLastOpenChecker.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/21/23.
//

import Foundation

// AppLastOpenChecker: A class to check if the app has expired based on the last open timestamp
class AppLastOpenChecker {
    private let storage: LastOpenStorage
    private let timeIntervalForExpiration: TimeInterval
    
    // Initialize the checker with the given storage and expiration time interval (default is 30 Mins)
    init(storage: LastOpenStorage = UserDefaultsLastOpenStorage(),
         timeIntervalForExpiration: TimeInterval = 30 * 60) {
        self.storage = storage
        self.timeIntervalForExpiration = timeIntervalForExpiration
    }
    
    // Check if the app has expired based on the last open timestamp
    func hasExpired() -> Bool {
        if let lastOpenTimestamp = storage.getLastOpenTimestamp() {
            let currentTimeStamp = Date().timeIntervalSince1970
            return (currentTimeStamp - lastOpenTimestamp) > timeIntervalForExpiration
        } else {
            // First time app is opened or data is not available, set current time as last open time
            storage.setLastOpenTimestamp(Date().timeIntervalSince1970)
            return false
        }
    }
}
