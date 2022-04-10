//
//  FabricModelCell.swift
//  VKClient
//
//  Created by Alex on 06.04.2022.
//

import UIKit

final class FabricModelCell {
    static func makeTextModelCell(with item: ResponseItem, and group: Group)-> AbstractModelCell {
        return NewsFeedPostTableViewCellModelImpl(with: item, and: group)
    }
    static func makeImageModelCell(with item: ResponseItem, and group: Group)-> AbstractModelCell {
        return NewsFeedImageTableViewCellModelImpl(with: item, and: group)
    }
}
