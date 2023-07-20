//
//  Currency.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//
import Foundation
import SwiftyJSON

typealias StringDoubleTuple = [(String, Double)]

// Struct representing the Currency object
struct Currency: Codable {
    let success: Bool
    let timestamp: Int?
    let base: String?
    let date: String?
    let error: CurrencyError?
    let rates: [String: Double]
    
    // Initialize the Currency object from JSON
    init(json: JSON) {
        // Extract values from JSON using SwiftyJSON
        success = json["success"].boolValue
        timestamp = json["timestamp"].int
        base = json["base"].string
        date = json["date"].string
        error = CurrencyError(json: json["error"])
        
        // Extract rates as a dictionary and convert values to Double
        rates = json["rates"].dictionaryValue.compactMapValues { $0.doubleValue }
    }
}

// Struct representing the CurrencyError object
struct CurrencyError: Codable {
    let code: Int?
    let type: String?
    let info: String?
    
    // Initialize the CurrencyError object from JSON
    init(json: JSON) {
        // Extract values from JSON using SwiftyJSON
        code = json["code"].int
        type = json["type"].string
        info = json["info"].string
    }
}
