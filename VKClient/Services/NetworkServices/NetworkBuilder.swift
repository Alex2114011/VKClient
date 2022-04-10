//
//  NetworkBuilder.swift
//  StocksLesson10
//
//  Created by Alex on 25.03.2022.
//

import Foundation

protocol NetworkBuilder {
    func createGetNewsFeedService() -> GetNewsFeedService
}

final class NetworkBuilderImpl {

}

extension NetworkBuilderImpl: NetworkBuilder {
    
    func createGetNewsFeedService() -> GetNewsFeedService {
        let storageBuilder = StorageBuilderImpl()
        let coreNetworkService = NetworkCoreImpl()
        let urlProvider = URLProviderImpl()
        let hostProvider = HostProviderImpl()
        let urlPrepare = URLPrepareImpl(hostProvider: hostProvider)
        let getNewsFeedService = GetNewsFeedServiceImpl(credintialStorage: storageBuilder, networkCoreService: coreNetworkService, urlProvider: urlProvider, urlPrepare: urlPrepare)
        return getNewsFeedService
    }
}
