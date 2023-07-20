//
//  ExchangeRateProvider.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import Foundation

// MARK: - ExchangeRateProvider Struct

// A struct responsible for providing currency conversion rates.
class ExchangeRateProvider {
    // MARK: - Properties
    
    private let rates: StringDoubleTuple
    
    // MARK: - Initialization
    
    // Initialize the ExchangeRateProvider with a tuple containing currency code and rate pairs.
    init(rates: StringDoubleTuple) {
        self.rates = rates
    }
    
    // MARK: - Currency Conversion Method
    
    // Calculate the conversion rate from the source currency to the target currency.
    // Returns nil if conversion is not possible or if currencies are the same.
    func getConversionRate(from sourceCurrency: String, to targetCurrency: String) -> Double? {
        // Check if source and target currencies are the same.
        guard sourceCurrency != targetCurrency else {
            return 1.0
        }
        
        // Get the rates for the source and target currencies.
        guard let sourceRate = getRate(for: sourceCurrency), let targetRate = getRate(for: targetCurrency) else {
            return nil
        }
        
        // Calculate the conversion rate and return it.
        return targetRate / sourceRate
    }
    
    // MARK: - Helper Method
    
    // Get the rate for a specific currency code.
    private func getRate(for currencyCode: String) -> Double? {
        return rates.first(where: { $0.0 == currencyCode })?.1
    }
}
