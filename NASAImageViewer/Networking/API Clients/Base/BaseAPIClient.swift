//
//  BaseAPIClient.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation
import Combine

/// Represents an API client error
enum APIClientError : Error {
    case reponseError(error: Error)
    case decodingError(error: DecodingError)
    case unknownError
}

/// Represents a generic HTTP response
struct HTTPResponse<T> {
    let value: T
    let response: URLResponse
}

/// The base class for all API clients
class BaseAPIClient {
    private let session: URLSession

    // MARK: - Initializers

    required init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - Public

    /// Performs URL requests with generic JSON decoding support
    /// - Parameters:
    ///   - request: The URL request
    ///   - decoder: The JSON decoder
    /// - Returns: A publisher that transmits generic `HTTPResponse` data over time
    func perform<T: Decodable>(request: URLRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<HTTPResponse<T>, APIClientError> {
        decoder.dateDecodingStrategy = APIConfiguration.Decoding.dateDecondingStrategy
        return session.dataTaskPublisher(for: request)
            .retry(3)
            .tryMap { result -> HTTPResponse<T> in
                let type = try decoder.decode(T.self, from: result.data)
                return HTTPResponse(value: type, response: result.response)
            }
            .mapError { error in
                if let error = error as? DecodingError {
                    return APIClientError.decodingError(error: error)
                } else {
                    return APIClientError.reponseError(error: error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
