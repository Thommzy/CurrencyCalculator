//
//  Endpoint.swift
//  Calculator
//
//  Created by Timothy Obeisun on 7/17/23.
//

import Foundation

// MARK: - EndpointProtocol Protocol

// The protocol defining properties required for an API endpoint.
protocol EndpointProtocol {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String { get }
}

// MARK: - Endpoint Enum

// The enumeration representing different API endpoints.
enum Endpoint: EndpointProtocol {
    
    // Define cases for each endpoint with associated values for parameters.
    case getLatestRate(
        access_key: String?,
        format: Int?
    )
    
    // MARK: - Properties
    
    // The scheme (e.g., "https") for the URL.
    var scheme: String {
        switch self {
        default:
            return AppString.https.localisedValue
        }
    }
    
    // The base URL for the API.
    var baseURL: String {
        switch self {
        case .getLatestRate(access_key: _, format: _):
            return AppString.baseURL.localisedValue
        }
    }
    
    // The path for the specific endpoint.
    var path: String {
        switch self {
        case .getLatestRate(access_key: _, format: _):
            return AppString.latest.localisedValue
        }
    }
    
    // The query parameters for the endpoint.
    var parameters: [URLQueryItem]? {
        switch self {
        case .getLatestRate(let access_key, let format):
            var queryItems: [URLQueryItem] = []
            if let accessKey = access_key {
                queryItems.append(URLQueryItem(name: "access_key", value: accessKey))
            }
            if let format = format {
                queryItems.append(URLQueryItem(name: "format", value: String(format)))
            }
            return queryItems.isEmpty ? nil : queryItems
        }
    }
    
    // The HTTP method for the endpoint.
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
