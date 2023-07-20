//
//  HomeViewModel.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import RealmSwift

// MARK: - HomeNetworkServiceProtocol Protocol

// The protocol defining the network service methods for the HomeViewModel.
protocol HomeNetworkServiceProtocol {
    func getLatest(accessKey: String, format: Int, completion: @escaping (Result<Currency, Error>) -> Void)
}

// MARK: - HomeNetworkService Class

// The concrete implementation of the network service for the HomeViewModel.
class HomeNetworkService: HomeNetworkServiceProtocol {
    // Create an instance of the NetworkService.
    let service: NetworkServiceProtocol = NetworkService()
    
    // Fetch the latest currency rates from the API.
    func getLatest(accessKey: String, format: Int, completion: @escaping (Result<Currency, Error>) -> Void) {
        // Make a network request to the API using the NetworkService and handle the completion result.
        service.request(endpoint: .getLatestRate(access_key: accessKey, format: 1), completion: completion)
    }
}
