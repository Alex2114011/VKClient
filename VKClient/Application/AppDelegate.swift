//
//  AppDelegate.swift
//  VKClient
//
//  Created by Alex on 25.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var storageBuilder: StorageBuilder?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        storageBuilder = StorageBuilderImpl()
        guard let storageBuilder = storageBuilder else { return false }
        let credeintialStorage = storageBuilder.createSecureStorageService()
        print(credeintialStorage.secureStorageService.getToken(token: KeyToken.key.rawValue) as Any)
//        credeintialStorage.secureStorageService.deleteToken(token: KeyToken.key.rawValue)
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController, key: credeintialStorage)
        appCoordinator?.start()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}

