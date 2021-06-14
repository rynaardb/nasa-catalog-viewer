//
//  APICofiguration.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation

/// Represents the global API configuration
struct APIConfiguration {
    struct Decoding {
        static var dateDecondingStrategy: JSONDecoder.DateDecodingStrategy {
            let decodingDateFormatter = DateFormatter()
            decodingDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

            return JSONDecoder.DateDecodingStrategy.formatted(decodingDateFormatter)
        }
    }

    enum Endpoint {
        case imageSearch(keyword: String)

        var url: URL? {
            get {
                switch self {
                case .imageSearch(let keyword):
                    return APIEndpointFactory.createEndpointURL(path: "/search", queryItems: [URLQueryItem(name: "q", value: keyword)])
                }
            }
        }
    }
}
