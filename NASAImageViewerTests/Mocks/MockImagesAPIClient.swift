//
//  MockImagesAPIClient.swift
//  NASAImageViewerTests
//
//  Created by Rynaard Burger on 14.06.21.
//

import Foundation
import Combine

@testable import NASAImageViewer

class MockImagesAPIClient: ImagesAPIClientProtocol {
    var shouldReturnError = false

    // MARK: - Initialization

    convenience init() {
        self.init(false)
    }

    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    func searchImages(keyword: String) -> AnyPublisher<ImageSearchResult?, APIClientError> {
        let imageSearchResult = ImageSearchResult(items: [Image(data: [], links: [])])

        if !shouldReturnError {
            return Just(imageSearchResult)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        } else {
            return Just(nil)
                .setFailureType(to: APIClientError.self)
                .eraseToAnyPublisher()
        }
    }
}
