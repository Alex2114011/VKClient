//
//  UIviewController+Extension.swift
//  VKClient
//
//  Created by Alex on 09.04.2022.
//

import UIKit

extension UIViewController {

    func showToast(message: String) {
        let font = UIFont(name: "Helvetica-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14)
        let toastLabel = UILabel(
            frame: CGRect(
                x: self.view.frame.size.width/2 - 125,
                y: self.view.frame.size.height-200, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.numberOfLines = 2
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 5, options: .curveEaseOut) {
            toastLabel.alpha = 0.0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
