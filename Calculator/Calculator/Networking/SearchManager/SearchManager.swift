//
//  SearchManager.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/20/23.
//

import Foundation

// MARK: - SearchManagerProtocol Protocol

// The protocol defining the method for searching currency codes.
protocol SearchManagerProtocol {
    func searchCurrencyCode(
        str: String,
        arr: inout StringDoubleTuple,
        backupArr: StringDoubleTuple
    ) -> StringDoubleTuple
}

// MARK: - SearchManager Class

// The class responsible for searching currency codes in a tuple of currency code and rate pairs.
class SearchManager: SearchManagerProtocol {
    // MARK: - Currency Code Search Method
    
    // Search for currency codes containing the given string.
    // The search is performed on the backupArr, and the result is stored in arr.
    // Returns the filtered array of currency code and rate pairs.
    func searchCurrencyCode(
        str: String,
        arr: inout StringDoubleTuple,
        backupArr: StringDoubleTuple
    ) -> StringDoubleTuple {
        let array = backupArr
        var filteredArray: StringDoubleTuple = []
        
        // If the search string is empty, reset the array to the original backupArr.
        if str.isEmpty {
            arr = array
            return arr
        } else {
            // Perform case-insensitive search on currency codes in backupArr.
            let filteredFullName = array.map { $0.0.lowercased().contains(str.lowercased()) }
            var index = 0
            while index < filteredFullName.count {
                if filteredFullName[index] == true {
                    filteredArray.append(array[index])
                }
                index += 1
            }
            
            // Update arr with the filtered array and return the result.
            arr = filteredArray
            return arr
        }
    }
}
