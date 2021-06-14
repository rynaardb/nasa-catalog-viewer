//
//  ImageDetailViewController.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 14.06.21.
//

import UIKit

final class ImageDetailViewController: UIViewController {
    var viewModel: ImageDetailViewModel?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()

        bindViewModel()
    }

    // MARK: - Private

    private func setupLayout() {
        self.scrollView.addSubview(stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }

    private func bindViewModel() {
        DispatchQueue.global().async { [weak self] in
            if let imageURL = self?.viewModel?.imageURL,
               let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }

        self.titleLabel.text = viewModel?.titleText
        self.subTitleLabel.text = viewModel?.subTitleText
        self.descriptionTextView.text = viewModel?.descriptionText
    }
}
