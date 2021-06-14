//
//  Image.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation

/// Represents an image
struct Image: Codable {
    let data: [ImageData]
    let links: [ImageLink]?

    struct ImageData: Codable {
        let title: String
        let description: String
        let photographer: String?
        let dateCreated: Date

        enum CodingKeys: String, CodingKey {
            case title, description, photographer
            case dateCreated = "date_created"
        }
    }

    struct ImageLink: Codable {
        let href: String
    }
}
