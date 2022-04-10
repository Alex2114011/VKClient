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
        print("init \(self)")
        showFavoritesPostsViewController()
    }
}

//MARK: - NewsFeedCoordinator

extension FavoritesPostsCoordinatorImpl: FavoritesPostsCoordinator {
    func showFavoritesPostsViewController() {
//        let networkBuilder = NetworkBuilderImpl()
//        let newsViewModel = NewsFeedViewModelImpl(networkService: networkBuilder)
//        let newsFeedViewController = NewsFeedViewController(viewModel: newsViewModel)
//        navigationController.pushViewController(newsFeedViewController, animated: true)
    }
}
