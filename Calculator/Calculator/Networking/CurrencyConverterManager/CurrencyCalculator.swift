//
//  CurrencyCalculator.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import Foundation

// MARK: - CurrencyConverter Protocol

// The protocol defining the method for currency conversion.
protocol CurrencyConverter {
    func convert(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double?
}

// MARK: - CurrencyCalculator Class

// The class responsible for converting currency using an ExchangeRateProvider.
class CurrencyCalculator: CurrencyConverter {
    // MARK: - Properties
    
    private let exchangeRateProvider: ExchangeRateProvider
    
    // MARK: - Initialization
    
    // Initialize the CurrencyCalculator with an ExchangeRateProvider.
    init(exchangeRateProvider: ExchangeRateProvider) {
        self.exchangeRateProvider = exchangeRateProvider
    }
    
    // MARK: - Currency Conversion Method
    
    // Convert the amount from the source currency to the target currency.
    // Returns nil if conversion is not possible or if currencies are the same.
    func convert(
        amount: Double,
        from sourceCurrency: String,
        to targetCurrency: String
    ) -> Double? {
        // Get the conversion rate from the ExchangeRateProvider and calculate the result.
        return (exchangeRateProvider.getConversionRate(from: sourceCurrency, to: targetCurrency) ?? 0.0) * amount
    }
}
