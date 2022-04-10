//
//  NewsFeedViewModel.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//


import Foundation

protocol NewsFeedViewModel {
    var reloadTable:(()->())? { get set }
    var updataTable:(([IndexPath])->())? { get set }
    var viewCellModels: [AbstractModelCell] { get set }
    func fetchNews()
    func fetchNextNews()

}

final class NewsFeedViewModelImpl {

    //MARK: - Public property

    var viewCellModels: [AbstractModelCell] = []

    //MARK: - Callback
    var reloadTable:(()->())?
    var updataTable:(([IndexPath])->())?

    //MARK: - Private property

    private let networkService: NetworkBuilder
    private var newsFeedModel: [NewsFeedModelRaw] = []
    private var nextNewsFrom: String?

    //MARK: - Initialisation

    init(networkService: NetworkBuilder) {
        self.networkService = networkService
    }
}

//MARK: - NewsFeedViewModel

extension NewsFeedViewModelImpl: NewsFeedViewModel {

    func fetchNews() {
        let getNewsFeedService = networkService.createGetNewsFeedService()
        getNewsFeedService.getNewsFeed(countNews: 20, nextNews: nil) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.newsFeedModel = [data.array]
                    self.makeModels()
                    self.reloadTable?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchNextNews() {
        guard let nextNewsFrom = nextNewsFrom else { return }
        let getNewsFeedService = networkService.createGetNewsFeedService()
        getNewsFeedService.getNewsFeed(countNews: 10, nextNews: nextNewsFrom) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.newsFeedModel = [data.array]
                    var models:[AbstractModelCell] = []
                    self.newsFeedModel.forEach { model in
                        self.nextNewsFrom = model.response?.nextFrom
                        model.response?.items?.forEach({ item in
                            model.response?.groups?.forEach({ group in
                                guard let sourceID = item.sourceID else { return }
                                if abs(sourceID) == group.id {
                                    if item.copyHistory == nil {
                                        if item.attachments == nil {
                                            models.append(FabricModelCell.makeTextModelCell(with: item, and: group))
                                        } else if item.attachments?.first?.photo != nil {
                                            models.append(FabricModelCell.makeImageModelCell(with: item, and: group))
                                        }
                                    }
                                }
                            })
                        })
                    }
                    let startIndexPath = IndexPath(row: self.viewCellModels.count, section: 0)
                    let indexes: [IndexPath] = self.generateIndexPath(count: models.count, from: startIndexPath)
                    self.viewCellModels.append(contentsOf: models)
                    self.updataTable?(indexes)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - Public methods

extension NewsFeedViewModelImpl {
    private func generateIndexPath(count: Int, from index: IndexPath) -> [IndexPath] {
        var indexes: [IndexPath] = []
        for i in stride(from: index.row, to: index.row + count, by: 1) {
            indexes.append(IndexPath(row: i, section: index.section))
        }
        return indexes
    }
    
    private func makeModels() {
        newsFeedModel.forEach { model in
            nextNewsFrom = model.response?.nextFrom
            model.response?.items?.forEach({ item in
                model.response?.groups?.forEach({ group in
                    guard let sourceID = item.sourceID else { return }
                    if abs(sourceID) == group.id {
                        if item.copyHistory == nil {
                            if item.attachments == nil {
                                self.viewCellModels.append(FabricModelCell.makeTextModelCell(with: item, and: group))
                            } else if item.attachments?.first?.photo != nil {
                                self.viewCellModels.append(FabricModelCell.makeImageModelCell(with: item, and: group))
                            }
                        }
                    }
                })
            })
        }
    }
}
