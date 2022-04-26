//
//  FavoritesImagesPostsViewModel.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import UIKit

protocol FavoritesImagePostsViewModelCell {
    var staticCellHeight: CGFloat { get }
    var staticLabelHeight: CGFloat { get }
    var groupName: String { get }
    var textPost: String { get }
    var datePost: String { get }
    var likeCounts: String { get }
    var commentsCount: String { get }
    var viewsCount: String { get }
    var imageGroup: UIImage? { get }
    var heightTextLabel: CGFloat? { get }
    var imagePost: UIImage? { get }
    var isMoreButtonHidden: Bool { get }
    func change(height value: CGFloat)
}

final class FavoritesImagesPostsViewModelCellImpl: FavoritesImagePostsViewModelCell {
    
    //MARK: - Private property
    
    private var dynamicCellHeight: CGFloat = 0
    
    //MARK: - FavoritesImagesPostsViewModelCell
    
    var staticCellHeight: CGFloat = 437.5
    var staticLabelHeight: CGFloat = 33.3
    
    var groupName: String
    var textPost: String
    var datePost: String
    var likeCounts: String
    var commentsCount: String
    var viewsCount: String
    var imagePost: UIImage?
    var imageGroup: UIImage?
    var heightTextLabel: CGFloat?
    var isMoreButtonHidden: Bool = true
    
    //MARK: - Initialisation
    
    init(with postsModel: FavoritesPosts) {
        self.groupName = postsModel.groupName ?? ""
        self.textPost = postsModel.textPost ?? ""
        self.datePost = postsModel.datePost ?? ""
        self.likeCounts = postsModel.likeCounts ?? ""
        self.commentsCount = postsModel.commentsCount ?? ""
        self.viewsCount = postsModel.viewsCount ?? ""
        self.imageGroup = self.transformToImage(imageData: postsModel.imageGroup)
        self.imagePost = self.transformToImage(imageData: postsModel.imagePost)
        self.heightTextLabel = self.getHeightLabel(text: self.textPost)
        self.isMoreButtonHidden = self.isNeedHideMoreBotton(if: heightTextLabel ?? 0)
    }
}

//MARK: - Private methods

extension FavoritesImagesPostsViewModelCellImpl {
    
    private func transformToImage(imageData: Data?) -> UIImage {
        if let image = imageData {
            return UIImage(data: image)!
        } else {
            return UIImage(named: "no-photo")!
        }
    }
    
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

extension FavoritesImagesPostsViewModelCellImpl: AbstractModelCell {
    
    func cellIdentifier() -> String {
        return String(describing: FavoritesImagePostsTableViewCell.self)
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
