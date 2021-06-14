//
//  APIEndpointFactory.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation

/// A factory for creating new API endpoints.
struct APIEndpointFactory {
    static let baseURLString = "https://images-api.nasa.gov"

    /// Creates a new API endpoint URL
    /// - Parameters:
    ///   - path: The URL path
    ///   - queryItems: Optional URL query items
    /// - Returns: The URL of the API endpoint
    static func createEndpointURL(path: String, queryItems: [URLQueryItem]?) -> URL? {
        var urlComponents = URLComponents(string: baseURLString)!
        urlComponents.path = path

        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }

        return urlComponents.url!
    }
}
