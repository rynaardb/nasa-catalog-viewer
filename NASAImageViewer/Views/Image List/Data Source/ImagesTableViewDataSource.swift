//
//  ImagesTableViewDataSource.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 14.06.21.
//

import Foundation
import UIKit


/// The table view data source for the images list view
final class ImagesTableViewDataSource: NSObject {
    var images: [Image]?
}

extension ImagesTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ImageListTableViewCell()

        if let image = self.images?[indexPath.row] {
            let viewModel = ImageListTableViewCellModel(image: image)

            cell = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCell", for: indexPath) as! ImageListTableViewCell

            cell.tag = indexPath.row
            cell.thumbnailImageView.image = UIImage(named: "image-placeholder")

            DispatchQueue.global().async {
                if let thumbnailImageURL = viewModel.thumbnailImageURL,
                   let data = try? Data(contentsOf: thumbnailImageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            if cell.tag == indexPath.row {
                                cell.thumbnailImageView.image = image
                            }
                        }
                    }
                }
            }

            cell.titleLabel.text = viewModel.titleText
            cell.subTitleLabel.text = viewModel.subTitleText
        }

        return cell
    }
}
