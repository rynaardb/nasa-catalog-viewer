//
//  ImageListTableViewCell.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 14.06.21.
//

import UIKit

final class ImageListTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.subTitleLabel.text = nil
    }
}
