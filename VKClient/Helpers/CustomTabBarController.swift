//
//  CustomTabBarController.swift
//  Navigations
//
//  Created by Alex on 13.03.2022.
//

import UIKit

final class CustomTabBarController: UITabBarController {

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUITabBar()
    }
}

//MARK: - Private methods

extension CustomTabBarController {
    private func setupUITabBar() {
        view.backgroundColor = .white
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.clear

        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]

        appearance.compactInlineLayoutAppearance.normal.iconColor = .black
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]

        appearance.inlineLayoutAppearance.normal.iconColor = .black
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]

        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
        self.tabBar.tintColor = .black
    }
}
