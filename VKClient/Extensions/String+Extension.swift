//
//  String+Extension.swift
//  UIKitExamples
//
//  Created by Alex on 06.04.2022.
//

import UIKit

extension String {
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        let height = actualSize.integral.height
        return height
    }
}
