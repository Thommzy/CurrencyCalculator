//
//  String+Extension.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation

// MARK: - String Extension

// An extension to provide additional functionality to the String class.
extension String {
    // MARK: - Localized Value Method
    
    // Get the localized value of the string.
    // This method uses the NSLocalizedString function to retrieve the localized version of the string.
    func getLocalizedValue() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    // MARK: - Country Flag Method
    
    // Get the flag emoji for a given currency rate code.
    // The currency rate code is typically a combination of the country code and currency code (e.g., "USD").
    // The method extracts the country code (first two characters) and converts it into a flag emoji.
    // The method uses UnicodeScalar values to map the country code to its corresponding flag emoji.
    func countryFlag(rateCode: String) -> String {
        let countryCode = String(rateCode.prefix(2))
        let base: UInt32 = 127397
        
        var flagString = ""
        countryCode.uppercased().unicodeScalars.forEach {
            if let unicodeScalar = UnicodeScalar(base + $0.value) {
                flagString.append(String(unicodeScalar))
            }
        }
        
        return flagString
    }
}
