//
//  Abstrations.swift
//  VKClient
//
//  Created by Alex on 09.04.2022.
//

import UIKit

protocol AbstractCell: UITableViewCell {
    func configureCell(with object: AbstractModelCell)
    var updateRow:(()->())? { get set }
}

protocol AbstractModelCell {
    func height() -> CellHeight
    func cellIdentifier() -> String
}

enum CellHeight {
    case value(CGFloat)
}
