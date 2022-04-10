//
//  GetNewsFeedService.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//

import Foundation

protocol GetNewsFeedService {
    func getNewsFeed(countNews: Int, nextNews: String?, completion: @escaping ((Result<NewsFeedResponse, Error>) -> Void))
}

final class GetNewsFeedServiceImpl: GetNewsFeedService {

    //MARK: - Private property

    private let headerParameter: [String: String] = [:]
    private let credintialStorage: StorageBuilder
    private let networkCoreService: NetworkCore
    private let urlProvider: URLProvider
    private let urlPrepare: URLPrepare

    //MARK: - Initialisation

    init(credintialStorage: StorageBuilder ,networkCoreService: NetworkCore, urlProvider: URLProvider, urlPrepare: URLPrepare) {
        self.credintialStorage = credintialStorage
        self.networkCoreService = networkCoreService
        self.urlProvider = urlProvider
        self.urlPrepare = urlPrepare
    }

    //MARK: - Public methods

    func getNewsFeed(countNews: Int, nextNews: String?, completion: @escaping ((Result<NewsFeedResponse, Error>) -> Void)) {
        let credentialStorage = credintialStorage.createSecureStorageService()
        guard let token = credentialStorage.secureStorageService.getToken(token: KeyToken.key.rawValue) else { return }
        let parameters = ["filters": "post",
                          "count": "\(countNews)",
                          "start_from":"\(nextNews ?? "")",
                          "access_token": token, "v": "5.131"]
        let urlRequest = urlPrepare.prepareSearchRequest(url: urlProvider.getNewsFeed, parameters: parameters, httpMethod: .get, headerParameters: nil, data: nil)

        networkCoreService.sendRequest(urlRequest: urlRequest, completion: completion)
    }
}
