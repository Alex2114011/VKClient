//
//  FavoritesPostsCoordinator.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

protocol FavoritesPostsCoordinator: AnyObject {
    func showFavoritesPostsViewController()
}

final class FavoritesPostsCoordinatorImpl: Coordinator {

    //MARK: - Public property

    var navigationController: UINavigationController

    //MARK: - Initialisation

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFavoritesPostsViewController()
    }
}

//MARK: - FavoritesPostsCoordinator

extension FavoritesPostsCoordinatorImpl: FavoritesPostsCoordinator {
    func showFavoritesPostsViewController() {
        let favoritesPostsViewModel = FavoritesPostsViewModelImpl()
        let favoritesPostsViewController = FavoritesPostsViewController(viewModel: favoritesPostsViewModel)
        navigationController.pushViewController(favoritesPostsViewController, animated: true)
    }
}
