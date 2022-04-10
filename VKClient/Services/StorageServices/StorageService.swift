//
//  StorageProtocol.swift
//  VKClient
//
//  Created by Alex on 01.04.2022.
//

import Foundation

protocol StorageService: AnyObject {
    var secureStorageService: KeyChainService { get set}
}

final class StorageServiceImpl: StorageService {
    var secureStorageService: KeyChainService

    init(secureStorageService: KeyChainService) {
        self.secureStorageService = secureStorageService
    }
}
