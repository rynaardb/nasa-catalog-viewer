//
//  ImagesAPIClientProtocol.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 14.06.21.
//

import Foundation
import Combine

/// A protocol for defining an image API client
protocol ImagesAPIClientProtocol {
    func searchImages(keyword: String) -> AnyPublisher<ImageSearchResult?, APIClientError>
}
