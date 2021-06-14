//
//  ImageSearchResult.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation

/// Represents an image search result
struct ImageSearchResult: Decodable {
    let items: [Image]

    enum CodingKeys: String, CodingKey {
        case items
        case collection = "collection"
    }

    struct ImageItemCollection: Codable {
        let items: [Image]
    }

    init(items: [Image]) {
        self.items = items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let collection = try container.decode(ImageItemCollection.self, forKey: .collection)

        self.items = collection.items
    }
}
