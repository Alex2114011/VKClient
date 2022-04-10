//
//  StorageBuilder.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//

import Foundation

protocol StorageBuilder {
        func createSecureStorageService() -> StorageService
}

final class StorageBuilderImpl: StorageBuilder {
    func createSecureStorageService() -> StorageService {
        let keyChainService:KeyChainService = KeychainServiceImpl()
        let secureService = StorageServiceImpl(secureStorageService: keyChainService)
        return secureService
    }
}
