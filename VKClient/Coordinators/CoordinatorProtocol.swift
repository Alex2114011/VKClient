//
//  Coordinator.swift
//  VKClient
//
//  Created by Alex on 30.03.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
