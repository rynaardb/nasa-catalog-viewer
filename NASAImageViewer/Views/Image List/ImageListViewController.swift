//
//  ImageListViewController.swift
//  NASAImageViewer
//
//  Created by Rynaard Burger on 13.06.21.
//

import UIKit
import Combine

final class ImageListViewController: UITableViewController {
    var viewModel: ImageListViewModel?
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: ImagesTableViewDataSource?
    private var loadingViewController: UIViewController?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "The Milky Way"

        self.dataSource = ImagesTableViewDataSource()

        self.tableView.dataSource = self.dataSource

        presentLoadingViewController()

        bindViewModel()

        viewModel?.fetchImages()
    }

    // MARK: View model bindings

    private func bindViewModel() {
        let apiClient = ImagesAPIClient()
        viewModel = ImageListViewModel(apiClient: apiClient)

        viewModel?.$images
            .sink { [weak self] in self?.renderImageList($0) }
            .store(in: &cancellables)

        viewModel?.$error
            .sink { [weak self] in self?.presentAlertForError($0) }
            .store(in: &cancellables)

        viewModel?.$fetchImagesDidFinish
            .sink { _ in self.finishLoadingImages() }
            .store(in: &cancellables)
    }

    // MARK: - Private

    private func renderImageList(_ images: [Image]) {
        self.dataSource?.images = images
        self.tableView.reloadData()
    }

    private func presentAlertForError(_ error: APIClientError?) {
        guard let error = error else { return }

        dismissLoadingViewController()

        let alertAction = UIAlertAction(title: "Retry", style: .default) { action in
            self.presentLoadingViewController()
            self.viewModel?.fetchImages()
        }

        let alertController = UIAlertController(title: "That didn't work!", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(alertAction)

        self.present(alertController, animated: false, completion: nil)
    }

    private func finishLoadingImages() {
        guard let images = viewModel?.images else { return }

        if images.count > 0 {
            dismissLoadingViewController()
        }
    }

    private func presentLoadingViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)

        self.loadingViewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController")
        self.loadingViewController?.modalPresentationStyle = .fullScreen

        if let viewController = self.loadingViewController {
            self.present(viewController, animated: false, completion: nil)
        }
    }

    private func dismissLoadingViewController() {
        if let viewController = self.loadingViewController {
            viewController.dismiss(animated: false, completion: nil)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageDetail" {
            let imageDetailVC = segue.destination as! ImageDetailViewController

            if let image = self.dataSource?.images?[self.tableView.indexPathForSelectedRow!.row] {
                let viewModel = ImageDetailViewModel(image: image)
                imageDetailVC.viewModel = viewModel
            }
        }
    }
}
