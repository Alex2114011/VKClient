//
//  AppCoordinator.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    //MARK: - Private property

    private var credentialStorage: StorageService
    private var isLoggedIn = false
    private var childCoordinators: [Coordinator] = []

    //MARK: - Public property

    var navigationController: UINavigationController

    //MARK: - Initialisation

    init(navigationController: UINavigationController, key: StorageService) {
        self.navigationController = navigationController
        self.credentialStorage = key
    }

    //MARK: - Public methods

    func start() {
        if credentialStorage.secureStorageService.getToken(token: KeyToken.key.rawValue) != nil {
            showMain()
        } else {
            showAuthentication()
        }
    }
}

//MARK: - Private methods

extension AppCoordinator {
    
    private func showAuthentication() {
        let authenticationCoordinator = AuthenticationCoordinatorImp(navigationController: navigationController)
        authenticationCoordinator.start()
        childCoordinators.append(authenticationCoordinator)
        coordinatorDidAuthenticate(coordinatator: authenticationCoordinator)
    }

    private func showMain() {
        navigationController.viewControllers.removeAll()
        let mainTabBarCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        mainTabBarCoordinator.start()
        childCoordinators.append(mainTabBarCoordinator)
    }

    private func coordinatorDidAuthenticate(coordinatator: AuthenticationCoordinator) {
        coordinatator.coordinatorDidAuthenticate = { [weak self] coordinator in
            guard let self = self else { return }
            self.childDidFinish(coordinator)
            self.showMain()
        }
    }

    private func childDidFinish(_ coordinator: Coordinator ) {
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

