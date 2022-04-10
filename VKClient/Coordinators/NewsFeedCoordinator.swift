//
//  FeedCoordinator.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

protocol NewsFeedCoordinator: AnyObject {
    func showFeedViewController()
}

final class NewsFeedCoordinatorImp: Coordinator {

    //MARK: - Public property

    var navigationController: UINavigationController

    //MARK: - Initialisation

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFeedViewController()
    }
}

//MARK: - NewsFeedCoordinator

extension NewsFeedCoordinatorImp: NewsFeedCoordinator {
    func showFeedViewController() {
        let networkBuilder = NetworkBuilderImpl()
        let newsViewModel = NewsFeedViewModelImpl(networkService: networkBuilder)
        let newsFeedViewController = NewsFeedViewController(viewModel: newsViewModel)
        navigationController.pushViewController(newsFeedViewController, animated: true)

    }
}
