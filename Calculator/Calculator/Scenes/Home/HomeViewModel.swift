//
//  HomeViewModel.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift
import Combine

class HomeViewmodel {
    // MARK: - Properties
    
    // CurrentValueSubjects and PassthroughSubjects to handle various data and events.
    var currencyOneCurrencyCode = CurrentValueSubject<String, Never>("")
    var currencyTwoCurrencyCode = CurrentValueSubject<String, Never>("")
    var currencyTwoRate = PassthroughSubject<Double, Never>()
    var rateArray = CurrentValueSubject<[(String, Double)], Never>([(String, Double)]())
    var displayError = PassthroughSubject<String, Never>()
    
    // Dependency injection for network service and realm data manager.
    private let networkService: HomeNetworkServiceProtocol
    private let realmDataManager: PersistenceProtocol
    
    // MARK: - Initialization
    
    init(
        networkService: HomeNetworkServiceProtocol,
        realmDataManager: PersistenceProtocol
    ) {
        self.networkService = networkService
        self.realmDataManager = realmDataManager
    }
    
    // MARK: - Get Rates
    
    func getRates(accessKey: String, format: Int) {
        // Check if the database is empty
        let isDBEmpty = realmDataManager.isDatabaseEmpty(CurrencyRealm.self)
        
        if isDBEmpty {
            // Fetch data from the network if the database is empty
            networkService.getLatest(accessKey: accessKey, format: format) { [weak self] result in
                switch result {
                case .success(let rates):
                    // Convert the fetched data to a Realm object and save it to the database
                    if let currencyRealm = self?.convertToRealmObject(currency: rates) {
                        self?.realmDataManager.saveObject(currencyRealm)
                    }
                    break
                case .failure(let error):
                    // Notify the view about the error
                    self?.displayError.send(error.localizedDescription)
                    break
                }
            }
        } else {
            // Retrieve data from the database if it exists
            let data = retrieveDataFromDB()
            let rateList = convertRatesToTuple(rates: data?.rates)
            currencyOneCurrencyCode.send(data?.base ?? "")
            currencyTwoRate.send(data?.rates.first?.rate ?? 0.0)
            currencyTwoCurrencyCode.send(data?.rates.first?.currencyCode ?? "")
            rateArray.send(rateList)
        }
    }
    
    // MARK: - Conversion Methods
    
    func convertRatesToTuple(rates: List<RateRealm>?) -> [(String, Double)] {
        if let rates = rates {
            let convertedRates = Array(rates)
            return convertedRates.map { ($0.currencyCode, $0.rate) }
        }
        return [(String, Double)]()
    }
    
    func convertToRealmObject(currency: Currency) -> CurrencyRealm {
        let currencyRealm = CurrencyRealm()
        currencyRealm.success = currency.success
        currencyRealm.timestamp = currency.timestamp ?? 0
        currencyRealm.base = currency.base ?? ""
        currencyRealm.date = currency.date ?? ""
        
        let ratesList = List<RateRealm>()
        for (currencyCode, rate) in currency.rates {
            let rateRealm = RateRealm()
            rateRealm.currencyCode = currencyCode
            rateRealm.rate = rate
            ratesList.append(rateRealm)
        }
        currencyRealm.rates = ratesList
        
        return currencyRealm
    }
    
    // MARK: - Retrieve Data from Database
    
    func retrieveDataFromDB() -> CurrencyRealm? {
        guard let results = realmDataManager.fetchObjects(CurrencyRealm.self) else {
            return nil
        }
        
        let data = results.first as? CurrencyRealm
        return data
    }
    
    func getAccessKey() -> String {
        if let accessKey = Bundle.main.infoDictionary?["accessKey"] as? String {
            // Use myValue in your code
            return accessKey
        }
        return ""
    }
    
}
