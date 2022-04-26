//
//  UITableViewExtension.swift
//  VKClient
//
//  Created by Alex on 02.04.2022.
//

import UIKit


extension UITableView {

    func register<T: UITableViewCell>(cell: T.Type) {
        let name = String(describing: cell.self)
        register(cell, forCellReuseIdentifier: name)
    }
}
