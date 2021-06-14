//
//  ImagesAPIClient.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation
import Combine

/// Concrete implementation of the images API client
final class ImagesAPIClient: BaseAPIClient, ImagesAPIClientProtocol {
    /// Searches the NASA images API for images
    /// - Parameter keyword: The search keyword
    /// - Returns: A publisher that transmits `ImageSearchResult` data over time
    func searchImages(keyword: String) -> AnyPublisher<ImageSearchResult?, APIClientError> {
        let url = APIConfiguration.Endpoint.imageSearch(keyword: keyword).url!

        return perform(request: URLRequest(url: url))
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
