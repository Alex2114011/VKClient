//
//  FavoritesPostsViewModel.swift
//  VKClient
//
//  Created by Alex on 10.04.2022.
//

import CoreData

protocol FavoritesPostsViewModel {
    var reloadTable:(()->())? { get set }
    var viewCellModels: [AbstractModelCell] { get }
    func fetchFavoritesPosts()
    func deleteFavoritesPosts(with index: Int)
    func zeroingViewCellModels()
}

final class FavoritesPostsViewModelImpl {

    var reloadTable:(()->())?
    var viewCellModels: [AbstractModelCell] = []

    //MARK: - Private property

    private var postsModel: [FavoritesPosts]?
}

//MARK: - FavoritesPostsViewModel

extension FavoritesPostsViewModelImpl: FavoritesPostsViewModel {

    func fetchFavoritesPosts() {
        let postFetch: NSFetchRequest<FavoritesPosts> = FavoritesPosts.fetchRequest()

        do {
            postsModel = try CoreDataStack.shared.managedContext.fetch(postFetch)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        postsModel?.forEach({ favoritesPosts in
            viewCellModels.append(FabricModelCell.makeFavoritesModelCell(with: favoritesPosts))
        })
        
        reloadTable?()
    }

    func zeroingViewCellModels() {
        viewCellModels = []
        reloadTable?()
    }

    func deleteFavoritesPosts(with index: Int) {
        guard let postToRemove = postsModel?[index] else { return }
        print(index)

        viewCellModels.remove(at: index)
        postsModel?.remove(at: index)

        CoreDataStack.shared.managedContext.delete(postToRemove)
        CoreDataStack.shared.saveContext()
    }
}
