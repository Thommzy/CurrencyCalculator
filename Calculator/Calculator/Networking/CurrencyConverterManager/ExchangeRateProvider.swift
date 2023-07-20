//
//  CurrencyConverter.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/18/23.
//

import Foundation

struct CurrencyRate {
    let currencyCode: String
    let rate: Double
}

protocol CurrencyConverter {
    func convert(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double?
}

class ExchangeRateProvider {
    private let rates: [CurrencyRate]
    
    init(rates: [CurrencyRate]) {
        self.rates = rates
    }
    
    func getConversionRate(from sourceCurrency: String, to targetCurrency: String) -> Double? {
        guard sourceCurrency != targetCurrency else {
            return 1.0
        }
        
        guard let sourceRate = getRate(for: sourceCurrency), let targetRate = getRate(for: targetCurrency) else {
            return nil
        }
        
        return targetRate / sourceRate
    }
    
    private func getRate(for currencyCode: String) -> Double? {
        return rates.first(where: { $0.currencyCode == currencyCode })?.rate
    }
}

class CurrencyCalculator: CurrencyConverter {
    private let exchangeRateProvider: ExchangeRateProvider
    
    init(exchangeRateProvider: ExchangeRateProvider) {
        self.exchangeRateProvider = exchangeRateProvider
    }
    
    func convert(amount: Double, from sourceCurrency: String, to targetCurrency: String) -> Double? {
        return (exchangeRateProvider.getConversionRate(from: sourceCurrency, to: targetCurrency) ?? 0.0) * amount
    }
}

//// Usage example:
//let rates: [CurrencyRate] = [("XPF", 119.926849), ("BRL", 5.437621), ("XOF", 655.276984), ...]
//
//let exchangeRateProvider = ExchangeRateProvider(rates: rates)
//let currencyCalculator = CurrencyCalculator(exchangeRateProvider: exchangeRateProvider)
//
//let amountToConvert = 100.0
//let sourceCurrency = "EUR"
//let targetCurrency = "USD"
//
//if let convertedAmount = currencyCalculator.convert(amount: amountToConvert, from: sourceCurrency, to: targetCurrency) {
//    print("\(amountToConvert) \(sourceCurrency) is equal to \(convertedAmount) \(targetCurrency)")
//} else {
//    print("Unable to perform the currency conversion.")
//}
