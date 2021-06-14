//
//  ImageListTableViewCellModel.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 14.06.21.
//

import Foundation

/// The view model for the images list view cell
struct ImageListTableViewCellModel {
    var image: Image
    
    // MARK: - Computed properties
    
    var thumbnailImageURL: URL? {
        URL(string: self.image.links?.first?.href ?? "")
    }
    
    var titleText: String {
        "\(image.data.first?.title ?? "Title unknown")"
    }
    
    var subTitleText: String {
        let imageData = image.data.first
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        return "\(imageData?.photographer ?? "Photographer unknown") | \(dateFormatter.string(from: imageData!.dateCreated))"
    }
}
