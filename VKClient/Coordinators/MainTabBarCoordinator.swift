//
//  MainTabBarController.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

final class MainTabBarCoordinator: Coordinator {

    //MARK: - Public property

    var navigationController: UINavigationController

    //MARK: - Private property

    private var childCoordinators: [Coordinator] = []

    //MARK: - Initialisation

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        initializeHomeTabBar()
        print("MainTabBar Coordinator Init")
        
    }
    deinit {
        print("HomeTabbar Coordinator Deinit")
    }

}

//MARK: - Private methods

extension MainTabBarCoordinator {
    private func initializeHomeTabBar() {
        let tabBar = CustomTabBarController()
        let feedNavigationController = UINavigationController()
        let feedCoordinator = NewsFeedCoordinatorImp(navigationController: feedNavigationController)
        let feedItem = UITabBarItem()
        feedItem.title = "Новости"
        feedItem.image = UIImage(named: "newspaper")
        feedNavigationController.tabBarItem = feedItem


        let favoritesNavigationController = UINavigationController()
        let favoritesCoordinator = FavoritesPostsCoordinatorImpl(navigationController: favoritesNavigationController)
        let favoritesItem = UITabBarItem()
        favoritesItem.title = "Избранное"
        favoritesItem.image = UIImage(systemName: "star")
        favoritesNavigationController.tabBarItem = favoritesItem


        tabBar.viewControllers = [feedNavigationController, favoritesNavigationController]
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(tabBar, animated: true)

        feedCoordinator.start()
        favoritesCoordinator.start()
    }
}
