//
//  Date+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import Foundation

// MARK: - Date Extension

// An extension to provide additional functionality to the Date class.
extension Date {
    // MARK: - Get Current Time in UTC Format Method
    
    // Get the current time in UTC format (HH:mm).
    // This method returns the current time in the UTC timezone formatted as "HH:mm".
    // It uses a DateFormatter with the UTC timezone and the "HH:mm" date format to convert the Date object to a string.
    // The resulting string represents the current time in the 24-hour format (e.g., "14:00").
    func getCurrentTimeInUTCFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "HH:mm"
        
        let currentTimeInUTC = Date()
        let formattedTime = dateFormatter.string(from: currentTimeInUTC)
        
        return formattedTime
    }
}
