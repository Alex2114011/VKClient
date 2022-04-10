//
//  AuthorizationViewModel.swift
//  VKClient
//
//  Created by Alex on 26.03.2022.
//

import Foundation

protocol AuthenticationViewModel {
    func saveToken(with key: KeyToken, token: String)
    func didAuthenticationpassed()
    var authenticationPassed: (()->())? { get set }
}

final class AuthenticationViewModelImpl {

    //MARK: - Callback

    var authenticationPassed: (()->())?

    //MARK: - Private property
    
    private let storage: KeyChainService


    //MARK: - Initialisation

    init(storage: KeyChainService) {
        self.storage = storage
    }

    deinit {
        print("dealloc \(self)")
    }
}

//MARK: - AuthenticationViewModel

extension AuthenticationViewModelImpl: AuthenticationViewModel {
    func didAuthenticationpassed() {
        authenticationPassed?()
    }
    
    func saveToken(with key: KeyToken, token: String) {
        storage.saveToken(token: key.rawValue, key: token)
    }
}

