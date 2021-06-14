//
//  ImagesAPIClientTests.swift
//  NASAImageViewerTests
//
//  Created by Rynaard Burger on 14.06.21.
//

import XCTest

@testable import NASAImageViewer

class ImagesAPIClientTests: XCTestCase {
    var mockImagesAPIClient: MockImagesAPIClient!

    override func setUpWithError() throws {
        mockImagesAPIClient = MockImagesAPIClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenSearchSucceedsThenResponseIsNotNil() throws {
        let expectation = XCTestExpectation(description: "searchImages success response")

        _ = mockImagesAPIClient.searchImages(keyword: "")
            .sink(receiveCompletion: { _ in}, receiveValue: { response in
                XCTAssertNotNil(response)
                expectation.fulfill()
            })

        wait(for: [expectation], timeout: 1)
    }

    func testWhenSearchSucceedsThenResponseIsCorrectType() throws {
        let expectation = XCTestExpectation(description: "searchImages success type")

        _ = mockImagesAPIClient.searchImages(keyword: "")
            .sink(receiveCompletion: { _ in}, receiveValue: { response in
                XCTAssertNotNil(response! as ImageSearchResult)
                expectation.fulfill()
            })

        wait(for: [expectation], timeout: 1)
    }

    func testWhenSearchFailsThenCompletionReturnsWithError() throws {
        mockImagesAPIClient.shouldReturnError = true

        let expectation = XCTestExpectation(description: "searchImages error")

        _ = mockImagesAPIClient.searchImages(keyword: "")
            .sink(receiveCompletion: { completion in
                XCTAssertNotNil(completion)
                expectation.fulfill()
            }, receiveValue: { _ in})

        wait(for: [expectation], timeout: 1)
    }
}
