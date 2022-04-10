//
//  FavoritesPostsViewController.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

final class FavoritesPostsViewController: UIViewController {

    //MARK: - Private property

    private var viewModel: FavoritesPostsViewModel

    private lazy var favoritesPostsView: FavoritesPostsView = {
        let view = FavoritesPostsView()
        return view
    }()

    //MARK: - Initialisation

    init(viewModel: FavoritesPostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life cycle

    override func loadView() {
        self.view = favoritesPostsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Избранное"
        navigationController?.hidesBarsOnSwipe = true
        configureTableView()
        viewModel.fetchFavoritesPosts()
        reloadTable()
    }
}

//MARK: - Private methods

extension FavoritesPostsViewController {
    private func configureTableView() {
//        favoritesPostsView.favoritesPostsTableView.delegate = self
//        favoritesPostsView.favoritesPostsTableView.dataSource = self
        favoritesPostsView.favoritesPostsTableView.register(cell: NewsFeedPostTableViewCell.self)
        favoritesPostsView.favoritesPostsTableView.register(cell: NewsFeedImageTableViewCell.self)
    }

    private func reloadTable() {
        viewModel.reloadTable = { [weak self] in
            guard let self = self else { return }
            self.favoritesPostsView.favoritesPostsTableView.reloadData()
        }
    }

    private func presentDetailViewController(with image: UIImage) {
        let vc = DetailImageViewController(image: image)
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource

//extension FavoritesPostsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        viewModel.viewCellModels.count
//    }





//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = viewModel.viewCellModels[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellIdentifier(), for: indexPath) as! AbstractCell
//        cell.configureCell(with: item)
//        cell.updateRow = {
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        let imageCell = cell as? NewsFeedImageTableViewCell
//        imageCell?.passImage = { image in
//            self.presentDetailViewController(with: image)
//        }
//        return cell
//    }
//}

//MARK: - UITableViewDelegate

//extension FavoritesPostsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row - 3 >= viewModel.viewCellModels.count - 4 {
//            viewModel.fetchNextNews()
//        }
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let item = viewModel.viewCellModels[indexPath.row].height()
//        switch item {
//        case .value(let height):
//            return CGFloat(height)
//        }
//    }
//}

