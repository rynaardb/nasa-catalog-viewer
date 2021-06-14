//
//  ImageListViewModel.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation
import Combine

/// An observable view model for the images list view
final class ImageListViewModel: ObservableObject {
    private let apiClient: ImagesAPIClientProtocol

    @Published private(set) var images: [Image] = []
    @Published private(set) var error: APIClientError?
    @Published private(set) var fetchImagesDidFinish: Bool?

    // MARK: - Initializers

    /// Initialized a new view model instance
    /// - Parameter apiClient: An API client conforming to `ImagesAPIClientProtocol`
    required init(apiClient: ImagesAPIClientProtocol) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public

    /// Fetches the images using the provided API client
    /// - Parameter completionHandler: The completion handler that will be invoked once the asynchronous task completes
    func fetchImages() {
        apiClient.searchImages(keyword: "milky way")
            .subscribe(Subscribers.Sink(
                        receiveCompletion: { completion in
                            switch completion {
                            case .failure(let error):
                                self.error = error
                            case .finished:
                                self.fetchImagesDidFinish = true
                            }
                        }, receiveValue: { value in
                            self.images = value?.items ?? []
                        }))
    }
}
