//
//  HomeViewModel.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift

protocol HomeNetworkServiceProtocol {
    func getLatest(accessKey: String, format: Int, completion: @escaping (Result<Currency, Error>) -> Void)
}

class HomeNetworkService: HomeNetworkServiceProtocol {
    let service: NetworkServiceProtocol = NetworkService()
    let database: PersistenceProtocol = PersistenceManager()
    
    func getLatest(accessKey: String, format: Int, completion: @escaping (Result<Currency, Error>) -> Void) {
        service.request(endpoint: .getLatestRate(access_key: accessKey, format: 1), completion: completion)
    }
}


