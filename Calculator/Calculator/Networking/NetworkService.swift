//
//  NetworkService.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation
import Alamofire

// MARK: - NetworkServiceProtocol Protocol

// The protocol defining methods for making network requests.
protocol NetworkServiceProtocol {
    func request<T: Codable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

// MARK: - NetworkService Class

// The class responsible for making network requests using Alamofire.
class NetworkService: NetworkServiceProtocol {
    // MARK: - EncodableParameters
    
    // A private struct to handle encodable query parameters.
    private struct EncodableParameters: Encodable {
        let queryItems: [String: String]
        
        enum CodingKeys: String, CodingKey {
            case queryItems
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            // Encode the query items into an array of strings for URL query parameters.
            let items = queryItems.map { $0.key + "=" + ($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") }
            try container.encode(items, forKey: .queryItems)
        }
    }
    
    // MARK: - Network Request Method
    
    // Perform a network request for a given endpoint and return the result.
    func request<T: Codable>(
        endpoint: Endpoint,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let url = URL(string: "\(endpoint.scheme)://\(endpoint.baseURL)\(endpoint.path)")!
        
        // Convert the endpoint parameters to a dictionary.
        var parameters: [String: Any] = [:]
        endpoint.parameters?.forEach { queryItem in
            parameters[queryItem.name] = queryItem.value
        }
        
        // Make a request using Alamofire.
        AF.request(url, method: .get, parameters: parameters)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    // Successfully decoded response data, send it to completion handler.
                    completion(.success(value))
                case .failure(let error):
                    // Handle any error during the request.
                    completion(.failure(error))
                }
            }
    }
}
