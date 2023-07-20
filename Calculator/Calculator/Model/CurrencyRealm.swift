//
//  CurrencyRealm.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift

// Realm object representing the Currency
class CurrencyRealm: Object {
    @Persisted var success: Bool                 // Flag indicating the success of the currency data
    @Persisted var timestamp: Int?               // Timestamp of the currency data
    @Persisted var base: String?                 // Base currency code
    @Persisted var date: String?                 // Date of the currency data
    @Persisted var rates: List<RateRealm>        // List of rates for different currencies
    
    override static func primaryKey() -> String? {
        return "base"                            // Primary key for CurrencyRealm is 'base'
    }
}

// Realm object representing the Rate
class RateRealm: Object {
    @Persisted var currencyCode: String          // Currency code
    @Persisted var rate: Double                  // Exchange rate for the currency
}
