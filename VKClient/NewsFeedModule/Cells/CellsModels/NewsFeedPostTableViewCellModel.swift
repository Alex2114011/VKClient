//
//  NewsFeedPostTableViewCellModel.swift
//  VKClient
//
//  Created by Alex on 03.04.2022.
//


import UIKit

protocol NewsFeedPostTableViewCellModel {
    var staticCellHeight: CGFloat { get }
    var staticLabelHeight: CGFloat { get }
    var groupName: String { get }
    var textPost: String { get }
    var datePost: String { get }
    var likeCounts: String { get }
    var commentsCount: String { get }
    var viewsCount: String { get }
    var imageGroupURLString: String { get }
    var heightTextLabel: CGFloat? { get }
    var isMoreButtonHidden: Bool { get }
    func change(height value: CGFloat)
}

final class NewsFeedPostTableViewCellModelImpl: NewsFeedPostTableViewCellModel {

    //MARK: - Private property

    private var dynamicCellHeight: CGFloat = 0
     var staticCellHeight: CGFloat = 227.5
     var staticLabelHeight: CGFloat = 33.6

    //MARK: - NewsFeedPostTableViewCellModel

    var groupName: String
    var textPost: String
    var datePost: String
    var likeCounts: String
    var commentsCount: String
    var viewsCount: String
    var imageGroupURLString: String
    var heightTextLabel: CGFloat?
    var isMoreButtonHidden: Bool = true

    //MARK: - Initialisation

    init(with item: ResponseItem, and group: Group) {
        self.groupName = group.name ?? ""
        self.textPost = item.text ?? ""
        self.datePost = item.date?.formatDate() ?? ""
        self.likeCounts = item.likes?.count?.formatNumber() ?? ""
        self.commentsCount = item.comments?.count?.formatNumber() ?? ""
        self.viewsCount = item.views?.count?.formatNumber() ?? ""
        self.imageGroupURLString = group.photo50 ?? ""
        self.heightTextLabel = self.getHeightLabel(text: item.text ?? "")
        self.isMoreButtonHidden = self.isNeedHideMoreBotton(if: heightTextLabel ?? 0)
    }
}

//MARK: - Private methods

extension NewsFeedPostTableViewCellModelImpl {

    private func getHeightLabel(text: String) -> CGFloat {
        let height = text.height(withWidth: UIScreen.main.bounds.width - 40, font: UIFont.systemFont(ofSize: 14, weight: .regular))
        return height
    }

    private func isNeedHideMoreBotton(if height: CGFloat)-> Bool {
        if height > staticLabelHeight {
            return false
        } else {
            staticCellHeight -= 17
            return true
        }
    }
}

//MARK: - AbstractModelCell

extension NewsFeedPostTableViewCellModelImpl: AbstractModelCell {
    func cellIdentifier() -> String {
        return String(describing: NewsFeedPostTableViewCell.self)
    }

    func height() -> CellHeight {

        if dynamicCellHeight != 0 {
            return .value(dynamicCellHeight)
        }
        return .value(staticCellHeight)
    }

    func change(height value: CGFloat) {
        if dynamicCellHeight == 0 {
            dynamicCellHeight = value
        }
    }
}
