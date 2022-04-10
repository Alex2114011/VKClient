//
//  UIView+Extension.swift
//  VKClient
//
//  Created by Alex on 02.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
