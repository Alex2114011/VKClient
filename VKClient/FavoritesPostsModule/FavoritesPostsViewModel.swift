//
//  FavoritesPostsViewModel.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import Foundation

protocol FavoritesPostsViewModel {
    func fetchFavoritesPosts()
    var reloadTable:(()->())? { get set }
    var viewCellModels: [AbstractModelCell] { get set }
}

final class FavoritesPostsViewModelImpl {


    private var postsModel: [NewsFeedModelRaw] = []


    func fetchFavoritesPosts() {
        
    }

}
