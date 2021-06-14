//
//  ImageDetailViewModel.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import Foundation

/// The view model for the image detail view
struct ImageDetailViewModel {
    var image: Image

    // MARK: - Computed properties

    var imageURL: URL? {
        URL(string: self.image.links?.first?.href ?? "")
    }

    var titleText: String {
        "\(image.data.first?.title ?? "Title unknown")"
    }

    var subTitleText: String {
        let imageData = image.data.first

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"

        return "\(imageData?.photographer ?? "Photographer unknown") | \(dateFormatter.string(from: imageData!.dateCreated) )"
    }

    var descriptionText: String {
        let imageData = image.data.first

        return "\(imageData?.description ?? "Description unknown")"
    }
}
